@extends('layouts.master')
@section('main-content')
@section('page-css')
<link rel="stylesheet" href="{{asset('assets/styles/vendor/datatables.min.css')}}">
@endsection

<div class="breadcrumb">
    <h1>Sub Categories</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_SubCategory_list">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <div class="text-end mb-3">
                    <button @click="showCreateModal()" class="btn btn-outline-primary btn-md m-1">
                        <i class="i-Add me-2 font-weight-bold"></i> Create
                    </button>
                </div>

                <div class="table-responsive">
                    <table id="sub_category_table" class="display table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Slug</th>
                                <th>Image</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($sub_categories as $sub_category)
                            <tr>
                                <td>{{ $sub_category->id }}</td>
                                <td>{{ $sub_category->name }}</td>
                                <td>{{ $sub_category->slug }}</td>
                                <td>
                                    @if($sub_category->image)
                                        <img src="{{ asset('storage/'.$sub_category->image) }}" alt="Sub Category Image" style="max-width: 50px; max-height: 50px;">
                                    @else
                                        No Image
                                    @endif
                                </td>
                                <td>
                                    <button @click="editSubCategory({{ $sub_category->id }})" class="btn btn-sm btn-primary me-2">
                                        <i class="i-Edit"></i> Edit
                                    </button>
                                    <button @click="deleteSubCategory({{ $sub_category->id }})" class="btn btn-sm btn-danger">
                                        <i class="i-Close"></i> Delete
                                    </button>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="modal_SubCategory" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">@{{ editmode ? 'Edit' : 'Create' }} Sub Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form @submit.prevent="editmode ? updateSubCategory() : createSubCategory()" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label">Name *</label>
                            <input type="text" v-model="sub_category.name" class="form-control" required>
                            <span class="text-danger" v-if="errors.name">@{{ errors.name[0] }}</span>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Image</label>
                            <input type="file" class="form-control" @change="handleImageUpload">
                            <span class="text-danger" v-if="errors.image">@{{ errors.image[0] }}</span>
                            <div v-if="sub_category.image" class="mt-2">
                                <img :src="getImageUrl(sub_category.image)" alt="Preview" style="max-width: 100px;">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <span v-if="SubmitProcessing" class="spinner-border spinner-border-sm"></span>
                            Submit
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('page-js')
<script src="{{asset('assets/js/vendor/datatables.min.js')}}"></script>
<script>
    new Vue({
        el: '#section_SubCategory_list',
        data: {
            sub_category: { 
                id: '', 
                name: '', 
                slug: '',
                image: null
            },
            editmode: false,
            SubmitProcessing: false,
            errors: [],
            dataTable: null
        },
        mounted() {
            this.initDataTable();
        },
        methods: {
            initDataTable() {
                this.dataTable = $('#sub_category_table').DataTable({
                    order: [[0, 'desc']],
                    columnDefs: [
                        { targets: [0], visible: false }
                    ]
                });
            },
            showCreateModal() {
                this.editmode = false;
                this.resetForm();
                $('#modal_SubCategory').modal('show');
            },
            resetForm() {
                this.sub_category = { 
                    id: '', 
                    name: '', 
                    slug: '',
                    image: null
                };
                this.errors = [];
            },
            handleImageUpload(event) {
                this.sub_category.image = event.target.files[0];
            },
            getImageUrl(image) {
                if (!image) return '';
                if (typeof image === 'string') {
                    return image.startsWith('http') ? image : `/storage/${image}`;
                }
                return URL.createObjectURL(image);
            },
            createSubCategory() {
                this.SubmitProcessing = true;
                let formData = new FormData();
                formData.append('name', this.sub_category.name);
                if (this.sub_category.image) {
                    formData.append('image', this.sub_category.image);
                }

                axios.post('/products/sub_categories', formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                })
                .then(() => {
                    this.refreshTable();
                    $('#modal_SubCategory').modal('hide');
                    toastr.success('Sub Category created successfully');
                })
                .catch(error => {
                    if (error.response.status === 422) {
                        this.errors = error.response.data.errors;
                    }
                    toastr.error('Error creating sub category');
                })
                .finally(() => {
                    this.SubmitProcessing = false;
                });
            },
            editSubCategory(id) {
                this.editmode = true;
                this.resetForm();
                axios.get(`/products/sub_categories/${id}/edit`)
                    .then(response => {
                        this.sub_category = response.data.sub_category;
                        $('#modal_SubCategory').modal('show');
                    })
                    .catch(() => {
                        toastr.error('Error loading sub category');
                    });
            },
            updateSubCategory() {
                this.SubmitProcessing = true;
                let formData = new FormData();
                formData.append('name', this.sub_category.name);
                formData.append('_method', 'PUT');
                if (this.sub_category.image && typeof this.sub_category.image !== 'string') {
                    formData.append('image', this.sub_category.image);
                }

                axios.post(`/products/sub_categories/${this.sub_category.id}`, formData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                })
                .then(() => {
                    this.refreshTable();
                    $('#modal_SubCategory').modal('hide');
                    toastr.success('Sub Category updated successfully');
                })
                .catch(error => {
                    if (error.response.status === 422) {
                        this.errors = error.response.data.errors;
                    }
                    toastr.error('Error updating sub category');
                })
                .finally(() => {
                    this.SubmitProcessing = false;
                });
            },
            deleteSubCategory(id) {
                if (confirm('Are you sure you want to delete this sub category?')) {
                    axios.delete(`/products/sub_categories/${id}`)
                        .then(() => {
                            this.refreshTable();
                            toastr.success('Sub Category deleted successfully');
                        })
                        .catch(() => {
                            toastr.error('Error deleting sub category');
                        });
                }
            },
            refreshTable() {
                this.dataTable.destroy();
                axios.get('/products/sub_categories')
                    .then(response => {
                        window.location.reload();
                    });
            }
        }
    });
</script>
@endsection