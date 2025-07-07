@extends('layouts.master')

@section('page-css')
<link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">
@endsection

@section('main-content')
<div class="breadcrumb"><h1>Sub Categories</h1></div>
<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_SubCategory_list">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <button @click="showCreateModal()" class="btn btn-outline-primary mb-3 float-end">
                    <i class="i-Add"></i> Create
                </button>

                <div class="table-responsive">
                    <table id="sub_category_table" class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Slug</th>
                                <th>Category</th>
                                <th>Image</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="modal_SubCategory" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog"><div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">@{{ editmode ? 'Edit' : 'Create' }} Sub Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form @submit.prevent="editmode ? updateSubCategory() : createSubCategory()" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label>Name *</label>
                        <input v-model="sub_category.name" type="text" class="form-control" required>
                        <span class="text-danger" v-if="errors.name">@{{ errors.name[0] }}</span>
                    </div>
                    <div class="mb-3">
                        <label>Category *</label>
                        <select v-model="sub_category.category_id" class="form-select" required>
                            <option disabled value="">Select Category</option>
                            <option v-for="cat in categories" :value="cat.id">@{{ cat.name }}</option>
                        </select>
                        <span class="text-danger" v-if="errors.category_id">@{{ errors.category_id[0] }}</span>
                    </div>
                    <div class="mb-3">
                        <label>Image</label>
                        <input type="file" class="form-control" @change="handleImageUpload">
                        <span class="text-danger" v-if="errors.image">@{{ errors.image[0] }}</span>
                        <div v-if="sub_category.image" class="mt-2">
                            <img :src="getImageUrl(sub_category.image)" style="max-width:100px;">
                        </div>
                    </div>
                    <button class="btn btn-primary" type="submit" :disabled="SubmitProcessing">
                        <span v-if="SubmitProcessing" class="spinner-border spinner-border-sm"></span>
                        Submit
                    </button>
                </form>
            </div>
        </div></div>
    </div>
</div>
@endsection

@section('page-js')
<script src="{{ asset('assets/js/vendor/datatables.min.js') }}"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
.swal-overlay {
    z-index: 999999 !important;

}
.swal-footer {
    text-align: center !important;
}

.swal-button-container {
    display: inline-block;
    margin: 0 5px;
}
</style>

<script>
new Vue({
    el: '#section_SubCategory_list',
    data: {
        sub_category: {
            id: '',
            name: '',
            category_id: '',
            image: null
        },
        categories: @json($categories),
        dataTable: null,
        errors: {},
        editmode: false,
        SubmitProcessing: false
    },
    mounted() {
        this.initDataTable();
    },
    methods: {
        initDataTable() {
            const self = this;
            this.dataTable = $('#sub_category_table').DataTable({
                processing: true,
                serverSide: true,
                ajax: "{{ route('sub_categories.index') }}",
                columns: [
                    { data: 'id', visible: false },
                    { data: 'name' },
                    { data: 'slug' },
                    { data: 'category' },
                    { data: 'image', orderable: false, searchable: false },
                    { data: 'action', orderable: false, searchable: false }
                ],
                drawCallback: function () {
                    setTimeout(() => {
                        $('.edit-btn').off().on('click', function () {
                            self.editSubCategory($(this).data('id'));
                        });
                        $('.delete-btn').off().on('click', function () {
                            self.deleteSubCategory($(this).data('id'));
                        });
                    }, 100);
                }
            });
        },
        refreshTable() {
            this.dataTable.ajax.reload(null, false);
        },
        showCreateModal() {
            this.editmode = false;
            this.resetForm();
            $('#modal_SubCategory').modal('show');
        },
        resetForm() {
            this.sub_category = { id: '', name: '', category_id: '', image: null };
            this.errors = {};
        },
        handleImageUpload(e) {
            this.sub_category.image = e.target.files[0];
        },
        getImageUrl(image) {
            if (!image) return '';
            return typeof image === 'string' ? `/storage/${image}` : URL.createObjectURL(image);
        },
        createSubCategory() {
            this.SubmitProcessing = true;
            let formData = new FormData();
            formData.append('name', this.sub_category.name);
            formData.append('category_id', this.sub_category.category_id);
            if (this.sub_category.image) formData.append('image', this.sub_category.image);

            axios.post('/products/sub_categories', formData)
                .then(() => {
                    this.refreshTable();
                    $('#modal_SubCategory').modal('hide');
                    this.resetForm();
                    swal("Created!", "Sub Category created successfully.", "success");
                }).catch(err => {
                    if (err.response.status === 422) {
                        this.errors = err.response.data.errors;
                    }
                    swal("Error!", "Validation failed.", "error");
                }).finally(() => this.SubmitProcessing = false);
        },
        editSubCategory(id) {
            this.editmode = true;
            this.resetForm();
            axios.get(`/products/sub_categories/${id}/edit`)
                .then(res => {
                    this.sub_category = res.data.sub_category;
                    $('#modal_SubCategory').modal('show');
                });
        },
        updateSubCategory() {
            this.SubmitProcessing = true;
            let formData = new FormData();
            formData.append('_method', 'PUT');
            formData.append('name', this.sub_category.name);
            formData.append('category_id', this.sub_category.category_id);
            if (this.sub_category.image && typeof this.sub_category.image !== 'string') {
                formData.append('image', this.sub_category.image);
            }

            axios.post(`/products/sub_categories/${this.sub_category.id}`, formData)
                .then(() => {
                    this.refreshTable();
                    $('#modal_SubCategory').modal('hide');
                    this.resetForm();
                    swal("Updated!", "Sub Category updated successfully.", "success");
                }).catch(err => {
                    if (err.response.status === 422) {
                        this.errors = err.response.data.errors;
                    }
                    swal("Error!", "Validation failed.", "error");
                }).finally(() => this.SubmitProcessing = false);
        },
        deleteSubCategory(id) {
            swal({
                title: "Are you sure?",
                text: "This will be deleted permanently!",
                icon: "warning",
                buttons: {
                    cancel: {
                        text: "Cancel",
                        visible: true,
                        className: "btn btn-danger"
                    },
                    confirm: {
                        text: "Yes, delete it!",
                        className: "btn btn-success"
                    }
                },
                dangerMode: true,
            }).then((willDelete) => {
                if (willDelete) {
                    axios.delete(`/products/sub_categories/${id}`)
                        .then(() => {
                            this.refreshTable();
                            swal("Deleted!", "Sub Category deleted successfully.", "success");
                        })
                        .catch(() => {
                            swal("Error!", "Failed to delete.", "error");
                        });
                }
            });
        }
    }
});
</script>
@endsection
