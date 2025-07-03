@extends('layouts.master')
@section('main-content')
@section('page-css')
<link rel="stylesheet" href="{{asset('assets/styles/vendor/nprogress.css')}}">
<link rel="stylesheet" href="{{asset('assets/styles/vendor/datepicker.min.css')}}">
@endsection

<div class="breadcrumb">
    <h1>{{ __('translate.Add_Product') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_create_product">
    <div class="col-lg-12 mb-3">
        <form @submit.prevent="Create_Product()">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label for="name">{{ __('translate.Product_Name') }} <span class="field_required">*</span></label>
                            <input type="text" class="form-control" id="name"
                                placeholder="{{ __('translate.Enter_Name_Product') }}" v-model="product.name">
                            <span class="error" v-if="errors && errors.name">
                                @{{ errors.name[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label for="code">{{ __('translate.Product_Code') }} <span class="field_required">*</span></label>
                            <div class="input-group">
                                <div class="input-group mb-3">
                                    <input v-model.number="product.code" type="text" class="form-control" placeholder="generate the barcode" aria-label="generate the barcode" aria-describedby="basic-addon2">
                                    <span class="input-group-text cursor-pointer" id="basic-addon2" @click="generateNumber()"><i class="i-Bar-Code"></i></span>
                                </div>
                            </div>
                            <span class="error" v-if="errors && errors.code">
                                @{{ errors.code[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Category') }} <span class="field_required">*</span></label>
                            <v-select placeholder="{{ __('translate.Choose_Category') }}" v-model="product.category_id"
                                :reduce="(option) => option.value"
                                :options="categories.map(categories => ({label: categories.name, value: categories.id}))">
                            </v-select>
                            <span class="error" v-if="errors && errors.category_id">
                                @{{ errors.category_id[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Brand') }} </label>
                            <v-select placeholder="{{ __('translate.Choose_Brand') }}" v-model="product.brand_id"
                                :reduce="(option) => option.value"
                                :options="brands.map(brands => ({label: brands.name, value: brands.id}))">
                            </v-select>
                        </div>

                        <div class="form-group col-md-4">
                            <label for="stock_alert">{{ __('translate.Order_Tax') }} </label>
                            <div class="input-group mb-3">
                                <input v-model.number="product.TaxNet" type="text" class="form-control" aria-describedby="basic-addon3">
                                <span class="input-group-text cursor-pointer" id="basic-addon3">%</span>
                            </div>
                        </div>

                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Tax_Method') }} </label>
                            <v-select placeholder="{{ __('translate.Choose_Method') }}" v-model="product.tax_method"
                                :reduce="(option) => option.value" :options="
                                              [
                                              {label: 'Exclusive', value: '1'},
                                              {label: 'Inclusive', value: '2'}
                                              ]">
                            </v-select>
                            <span class="error" v-if="errors && errors.tax_method">
                                @{{ errors.tax_method[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label for="image">{{ __('translate.Image') }} </label>
                            <input name="image" @change="onFileSelected" type="file" class="form-control" id="image">
                            <span class="error" v-if="errors && errors.image">
                                @{{ errors.image[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label for="multiple_images">{{ __('Multiple Images') }} </label>
                            <input name="multiple_images[]" @change="onMultipleFilesSelected" type="file" class="form-control" id="multiple_images" multiple>
                            <small class="form-text text-muted">{{ __('Supported formats') }}: JPEG, PNG, JPG, GIF</small>
                            <small class="form-text text-muted">{{ __('Max file size') }}: 2MB</small>
                            <span class="error" v-if="errors && errors.multiple_images">
                                @{{ errors.multiple_images[0] }}
                            </span>
                            <div v-if="product.multiple_images.length > 0" class="mt-2">
                                <div v-for="(file, index) in product.multiple_images" :key="index" class="d-inline-block mr-2">
                                    <small>@{{ file.name }}</small>
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-md-12 mb-4">
                            <label for="note">{{ __('translate.Please_provide_any_details') }} </label>
                            <textarea type="text" v-model="product.note" class="form-control" name="note" id="note"
                                placeholder="{{ __('translate.Please_provide_any_details') }}"></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-5">
                <div class="card-body">
                    <div class="row">
                        <div class="form-group col-md-4 mb-3">
                            <label>{{ __('translate.Product_Type') }} <span class="field_required">*</span></label>
                            <v-select placeholder="Product Type" v-model="product.type"
                                :reduce="(option) => option.value" :options="
                                                [
                                                {label: 'Standard Product', value: 'is_single'},
                                                {label: 'Service Product', value: 'is_service'},
                                                {label: 'Stitched Garment', value: 'stitched_garment'},
                                                {label: 'Unstitched Garment', value: 'unstitched_garment'},
                                                {label: 'Variant Product', value: 'is_variant'}
                                                ]" @input="handleProductTypeChange">
                            </v-select>
                            <span class="error" v-if="errors && errors.type">
                                @{{ errors.type[0] }}
                            </span>
                        </div>

                        <!-- Stitched Garment Measurements -->
                        <div v-if="product.type === 'stitched_garment'" class="col-md-12 mb-4">
                            <div class="card">
                                <div class="card-header bg-gray-200">
                                    <h5>Stitched Garment Measurements</h5>
                                </div>
                                <div class="card-body">
                                    <div class="form-group col-md-4 mb-3">
                                        <label>Garment Type <span class="field_required">*</span></label>
                                        <v-select placeholder="Select Garment Type" v-model="product.garment_type"
                                            :reduce="(option) => option.value" :options="
                                                            [
                                                            {label: 'Shirt/Suit', value: 'shirt_suit'},
                                                            {label: 'Pant/Shalwar', value: 'pant_shalwar'}
                                                            ]">
                                        </v-select>
                                    </div>

                                    <!-- Shirt/Suit Measurements -->
                                    <div v-if="product.garment_type === 'shirt_suit'">
                                        <h6>Shirt/Suit Measurements</h6>
                                        <div class="row">
                                            <div class="form-group col-md-4">
                                                <label>Length</label>
                                                <input type="text" class="form-control" v-model="product.shirt_length">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Shoulder</label>
                                                <input type="text" class="form-control" v-model="product.shirt_shoulder">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Sleeves</label>
                                                <input type="text" class="form-control" v-model="product.shirt_sleeves">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Chest</label>
                                                <input type="text" class="form-control" v-model="product.shirt_chest">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Upper Waist</label>
                                                <input type="text" class="form-control" v-model="product.shirt_upper_waist">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Lower Waist</label>
                                                <input type="text" class="form-control" v-model="product.shirt_lower_waist">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Hip</label>
                                                <input type="text" class="form-control" v-model="product.shirt_hip">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Neck</label>
                                                <input type="text" class="form-control" v-model="product.shirt_neck">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Arms</label>
                                                <input type="text" class="form-control" v-model="product.shirt_arms">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Cuff</label>
                                                <input type="text" class="form-control" v-model="product.shirt_cuff">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Biceps</label>
                                                <input type="text" class="form-control" v-model="product.shirt_biceps">
                                            </div>
                                        </div>
                                        
                                      <div class="form-group mt-3">
    <label>Collar Type</label>
    <div class="d-flex flex-wrap">
        <div class="form-check me-3">
            <input class="form-check-input" type="checkbox" id="collar_shirt" 
                   v-model="product.collar_shirt" true-value="1" false-value="0">
            <label class="form-check-label" for="collar_shirt">Shirt</label>
        </div>
        <div class="form-check me-3">
            <input class="form-check-input" type="checkbox" id="collar_sherwani" 
                   v-model="product.collar_sherwani" true-value="1" false-value="0">
            <label class="form-check-label" for="collar_sherwani">Sherwani</label>
        </div>
        <div class="form-check me-3">
            <input class="form-check-input" type="checkbox" id="collar_damian" 
                   v-model="product.collar_damian" true-value="1" false-value="0">
            <label class="form-check-label" for="collar_damian">Damian</label>
        </div>
        <div class="form-check me-3">
            <input class="form-check-input" type="checkbox" id="collar_round" 
                   v-model="product.collar_round" true-value="1" false-value="0">
            <label class="form-check-label" for="collar_round">Round</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="checkbox" id="collar_square" 
                   v-model="product.collar_square" true-value="1" false-value="0">
            <label class="form-check-label" for="collar_square">Square</label>
        </div>
    </div>
</div>
                                    </div>

                                    <!-- Pant/Shalwar Measurements -->
                                    <div v-if="product.garment_type === 'pant_shalwar'">
                                        <h6>Pant/Shalwar Measurements</h6>
                                        <div class="row">
                                            <div class="form-group col-md-4">
                                                <label>Length</label>
                                                <input type="text" class="form-control" v-model="product.pant_length">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Waist</label>
                                                <input type="text" class="form-control" v-model="product.pant_waist">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Hip</label>
                                                <input type="text" class="form-control" v-model="product.pant_hip">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Thai</label>
                                                <input type="text" class="form-control" v-model="product.pant_thai">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Knee</label>
                                                <input type="text" class="form-control" v-model="product.pant_knee">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Bottom</label>
                                                <input type="text" class="form-control" v-model="product.pant_bottom">
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label>Fly</label>
                                                <input type="text" class="form-control" v-model="product.pant_fly">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Unstitched Garment Details -->
                        <div v-if="product.type === 'unstitched_garment'" class="col-md-12 mb-4">
                            <div class="card">
                                <div class="card-header bg-gray-200">
                                    <h5>Unstitched Garment Details</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="form-group col-md-4">
                                            <label>Thaan Length (meters) <span class="field_required">*</span></label>
                                            <input type="number" class="form-control" v-model="product.thaan_length" 
                                                   step="0.01" min="0" readonly>
                                            <small class="form-text text-muted">Fixed at 22.5m per thaan</small>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <label>Suit Length (meters) <span class="field_required">*</span></label>
                                            <input type="number" class="form-control" v-model="product.suit_length" 
                                                   step="0.01" min="0" readonly>
                                            <small class="form-text text-muted">Fixed at 4.5m per suit</small>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <label>Available Sizes <span class="field_required">*</span></label>
                                            <div class="d-flex flex-wrap">
                                                <div v-for="size in availableSizes" :key="size" class="form-check me-3">
                                                    <input class="form-check-input" type="checkbox" 
                                                           :id="'size_'+size" :value="size" 
                                                           v-model="product.available_sizes">
                                                    <label class="form-check-label" :for="'size_'+size">
                                                        @{{ size }}
                                                    </label>
                                                </div>
                                            </div>
                                            <span class="error" v-if="errors && errors.available_sizes">
                                                @{{ errors.available_sizes[0] }}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-md-4" v-if="product.type == 'is_single' || product.type == 'stitched_garment' || product.type == 'unstitched_garment'">
                            <label for="cost">{{ __('translate.Product_Cost') }} <span class="field_required">*</span></label>
                            <input type="text" class="form-control" id="cost" placeholder="{{ __('translate.Enter_Product_Cost') }}"
                                v-model="product.cost">
                            <span class="error" v-if="errors && errors.cost">
                                @{{ errors.cost[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4" v-if="product.type == 'is_single' || product.type == 'is_service' || product.type == 'stitched_garment' || product.type == 'unstitched_garment'">
                            <label for="price">{{ __('translate.Product_Price') }} <span class="field_required">*</span></label>
                            <input type="text" class="form-control" id="price" placeholder="{{ __('translate.Enter_Product_Price') }}"
                                v-model="product.price">
                            <span class="error" v-if="errors && errors.price">
                                @{{ errors.price[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4" v-if="product.type != 'is_service'">
                            <label>{{ __('translate.Unit_Product') }} <span class="field_required">*</span></label>
                            <v-select @input="Selected_Unit" placeholder="{{ __('translate.Choose_Unit_Product') }}"
                                v-model="product.unit_id" :reduce="label => label.value"
                                :options="units.map(units => ({label: units.name, value: units.id}))">
                            </v-select>
                            <span class="error" v-if="errors && errors.unit_id">
                                @{{ errors.unit_id[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4" v-if="product.type != 'is_service'">
                            <label>{{ __('translate.Unit_Sale') }} <span class="field_required">*</span></label>
                            <v-select placeholder="{{ __('translate.Choose_Unit_Sale') }}"
                                v-model="product.unit_sale_id" :reduce="label => label.value"
                                :options="units_sub.map(units_sub => ({label: units_sub.name, value: units_sub.id}))">
                            </v-select>
                            <span class="error" v-if="errors && errors.unit_sale_id">
                                @{{ errors.unit_sale_id[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4" v-if="product.type != 'is_service'">
                            <label>{{ __('translate.Unit_Purchase') }} <span class="field_required">*</span></label>
                            <v-select placeholder="{{ __('translate.Choose_Unit_Purchase') }}"
                                v-model="product.unit_purchase_id" :reduce="label => label.value"
                                :options="units_sub.map(units_sub => ({label: units_sub.name, value: units_sub.id}))">
                            </v-select>
                            <span class="error" v-if="errors && errors.unit_purchase_id">
                                @{{ errors.unit_purchase_id[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4" v-if="product.type != 'is_service'">
                            <label for="qty_min">{{ __('translate.Minimum_sale_quantity') }} </label>
                            <input type="text" class="form-control" id="qty_min"
                                placeholder="{{ __('translate.Enter_Minimum_sale_quantity') }}"
                                v-model="product.qty_min">
                        </div>

                        <div class="form-group col-md-4" v-if="product.type != 'is_service'">
                            <label for="stock_alert">{{ __('translate.Stock_Alert') }} </label>
                            <input type="text" class="form-control" id="stock_alert"
                                placeholder="{{ __('translate.Enter_Stock_alert') }}" v-model="product.stock_alert">
                        </div>

                        <div class="col-md-9 mb-3 mt-3" v-if="product.type == 'is_variant'">
                            <div class="d-flex">
                                <input placeholder="Enter the Variant" type="text"
                                    name="variant" v-model="tag" class="form-control">
                                <a @click="add_variant(tag)" class=" ms-3 btn btn-md btn-primary">
                                    {{ __('translate.Add') }}
                                </a>
                            </div>
                        </div>

                        <div class="col-md-9 mb-2 " v-if="product.type == 'is_variant'">
                            <div class="table-responsive">
                                <table class="table table-hover table-sm">
                                    <thead class="bg-gray-300">
                                        <tr>
                                            <th scope="col">{{ __('translate.Variant_code') }}</th>
                                            <th scope="col">{{ __('translate.Variant_Name') }}</th>
                                            <th scope="col">{{ __('translate.Product_Cost') }}</th>
                                            <th scope="col">{{ __('translate.Product_Price') }}</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="variants.length <=0">
                                            <td colspan="3">{{ __('translate.No_data_Available') }}</td>
                                        </tr>
                                        <tr v-for="variant in variants">
                                           <td>
                                                <input required class="form-control" v-model="variant.code">
                                            </td>
                                            <td>
                                                <input required class="form-control" v-model="variant.text">
                                            </td>
                                            <td>
                                                <input required class="form-control" v-model="variant.cost">
                                            </td>
                                            <td>
                                                <input required class="form-control" v-model="variant.price">
                                            </td>
                                            <td>
                                                <a @click="delete_variant(variant.var_id)" class="btn btn-danger"
                                                    title="Delete">
                                                    <i class="i-Close-Window"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mt-5">
                <div class="card-body">
                    <!-- Product_Has_Imei_Serial_number -->
                    <div class="col-md-12 mb-2">
                        <div class="form-check form-check-inline">
                            <label class="checkbox checkbox-primary" for="is_imei">
                                <input type="checkbox" id="is_imei" v-model="product.is_imei">
                                <span>{{ __('translate.Product_Has_Imei/Serial_number') }}</span><span class="checkmark"></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-lg-6">
                    <button type="submit" class="btn btn-primary" :disabled="SubmitProcessing">
                        <span v-if="SubmitProcessing" class="spinner-border spinner-border-sm" role="status"
                            aria-hidden="true"></span> <i class="i-Yes me-2 font-weight-bold"></i> {{ __('translate.submit') }}
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
@endsection

@section('page-js')
<script src="{{asset('assets/js/nprogress.js')}}"></script>
<script src="{{asset('assets/js/bootstrap-tagsinput.js')}}"></script>
<script src="{{asset('assets/js/datepicker.min.js')}}"></script>
<script src="{{asset('assets/js/vendor/vuejs-datepicker/vuejs-datepicker.min.js')}}"></script>

<script>
    Vue.component('v-select', VueSelect.VueSelect)
    
    var app = new Vue({
        el: '#section_create_product',
        data: {
            tag: "",
            len: 8,
            SubmitProcessing: false,
            errors: [],
            categories: @json($categories),
            units: @json($units),
            units_sub: [],
            brands: @json($brands),
            variants: [],
            availableSizes: ['S', 'M', 'L', 'XL'],
            product: {
                type: "is_single",
                garment_type: "shirt_suit", // Default to shirt/suit
                name: "",
                code: "",
                Type_barcode: "",
                cost: "",
                price: "",
                brand_id: "",
                category_id: "",
                TaxNet: "0",
                tax_method: "1",
                unit_id: "",
                unit_sale_id: "",
                unit_purchase_id: "",
                stock_alert: "0",
                qty_min: 0,
                image: "",
                note: "",
                is_variant: false,
                is_imei: false,
                is_promo: false,
                promo_price: '',
                promo_start_date: new Date().toISOString().slice(0, 10),
                promo_end_date: '',
                multiple_images: [],
                
                // Shirt/Suit measurements
                shirt_length: '',
                shirt_shoulder: '',
                shirt_sleeves: '',
                shirt_chest: '',
                shirt_upper_waist: '',
                shirt_lower_waist: '',
                shirt_hip: '',
                shirt_neck: '',
                shirt_arms: '',
                shirt_cuff: '',
                shirt_biceps: '',
                
                // Pant/Shalwar measurements
                pant_length: '',
                pant_waist: '',
                pant_hip: '',
                pant_thai: '',
                pant_knee: '',
                pant_bottom: '',
                pant_fly: '',
                
                // Collar types (initialize as 0/false)
                collar_shirt: 0,
                collar_sherwani: 0,
                collar_damian: 0,
                collar_round: 0,
                collar_square: 0,
                
                // Unstitched Garment Properties
                thaan_length: 22.5,
                suit_length: 4.5,
                available_sizes: []
            },
        },
        
        methods: {
            generateNumber() {
                this.code_exist = "";
                this.product.code = Math.floor(
                    Math.pow(10, this.len - 1) +
                    Math.random() *
                    (Math.pow(10, this.len) - Math.pow(10, this.len - 1) - 1)
                );
            },
            
            onMultipleFilesSelected(e) {
                this.product.multiple_images = Array.from(e.target.files);
                const validTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'];
                const maxSize = 2 * 1024 * 1024;
                
                this.product.multiple_images = this.product.multiple_images.filter(file => {
                    return validTypes.includes(file.type) && file.size <= maxSize;
                });
                
                if (this.product.multiple_images.length !== e.target.files.length) {
                    toastr.warning('Some files were skipped due to invalid format or size');
                }
            },

            add_variant(tag) {
                if (this.variants.length > 0 && this.variants.some(variant => variant.text === tag)) {
                    toastr.error('Variant Duplicate');
                } else {
                    if(this.tag != ''){
                        var variant_tag = {
                            var_id: this.variants.length + 1,
                            text: tag,
                            code: '',
                            cost: '',
                            price: ''
                        };
                        this.variants.push(variant_tag);
                        this.tag = "";
                    } else {
                        toastr.error('Please Enter the Variant');
                    }
                }
            },

            delete_variant(var_id) {
                for (var i = 0; i < this.variants.length; i++) {
                    if (var_id === this.variants[i].var_id) {
                        this.variants.splice(i, 1);
                    }
                }
            },

            formatDate(d){
                var m1 = d.getMonth()+1;
                var m2 = m1 < 10 ? '0' + m1 : m1;
                var d1 = d.getDate();
                var d2 = d1 < 10 ? '0' + d1 : d1;
                return [d.getFullYear(), m2, d2].join('-');
            },

            getValidationState({ dirty, validated, valid = null }) {
                return dirty || validated ? valid : null;
            },
            
            onFileSelected(e){
                let file = e.target.files[0];
                this.product.image = file;
            },

            Get_Units_SubBase(value) {
                axios
                    .get("/products/Get_Units_SubBase?id=" + value)
                    .then(({ data }) => (this.units_sub = data));
            },

            Selected_Unit(value) {
                this.units_sub = [];
                this.product.unit_sale_id = "";
                this.product.unit_purchase_id = "";
                this.Get_Units_SubBase(value);
            },

            handleProductTypeChange(type) {
                if (type === 'unstitched_garment') {
                    this.product.thaan_length = 22.5;
                    this.product.suit_length = 4.5;
                    this.product.available_sizes = ['S', 'M', 'L', 'XL'];
                } else if (type === 'stitched_garment') {
                    this.product.garment_type = 'shirt_suit'; // Default to shirt/suit
                    this.product.available_sizes = ['S', 'M', 'L', 'XL'];
                } else {
                    this.product.available_sizes = [];
                }
            },

            prepareProductData() {
                // Create a deep copy of the product object
                let data = JSON.parse(JSON.stringify(this.product));
                
                // Convert collar types to integers (1 or 0)
                data.collar_shirt = data.collar_shirt ? 1 : 0;
                data.collar_sherwani = data.collar_sherwani ? 1 : 0;
                data.collar_damian = data.collar_damian ? 1 : 0;
                data.collar_round = data.collar_round ? 1 : 0;
                data.collar_square = data.collar_square ? 1 : 0;
                
                return data;
            },

            Create_Product() {
                if (this.product.type == 'is_variant' && this.variants.length <= 0) {
                    toastr.error('The variants array is required.');
                } else {
                    NProgress.start();
                    NProgress.set(0.1);
                    var self = this;
                    self.SubmitProcessing = true;

                    let formData = new FormData();
                    let productData = this.prepareProductData();

                    if (self.product.type == 'is_variant' && self.variants.length > 0) {
                        productData.is_variant = true;
                    } else {
                        productData.is_variant = false;
                    }

                    // Append product data
                    Object.entries(productData).forEach(([key, value]) => {
                        if (key !== 'multiple_images') {
                            if (key === 'available_sizes') {
                                formData.append(key, JSON.stringify(value));
                            } else {
                                formData.append(key, value);
                            }
                        }
                    });

                    // Append main image if exists
                    if (self.product.image instanceof File) {
                        formData.append('image', self.product.image);
                    }

                    // Append multiple images if exists
                    if (self.product.multiple_images.length > 0) {
                        self.product.multiple_images.forEach((file, index) => {
                            formData.append(`multiple_images[${index}]`, file);
                        });
                    }

                    // Append variants if exists
                    if (self.variants.length) {
                        formData.append("variants", JSON.stringify(self.variants));
                    }

                    // Send Data with axios
                    axios.post("/products/products", formData, {
                        headers: {
                            'Content-Type': 'multipart/form-data'
                        }
                    })
                    .then(response => {
                        NProgress.done();
                        self.SubmitProcessing = false;
                        window.location.href = '/products/products'; 
                        toastr.success('{{ __('translate.Created_in_successfully') }}');
                        self.errors = {};
                    })
                    .catch(error => {
                        NProgress.done();
                        self.SubmitProcessing = false;

                        if (error.response.status == 422) {
                            self.errors = error.response.data.errors;
                            toastr.error('{{ __('translate.There_was_something_wronge') }}');
                        }

                        if(self.errors.variants && self.errors.variants.length > 0){
                            toastr.error(self.errors.variants[0]);
                        }
                    });
                }
            }
        },
        
        watch: {
            'product.type': function(newVal, oldVal) {
                this.handleProductTypeChange(newVal);
            }
        },
        
        created() {
            // Initialize with default values if needed
        }
    });
</script>
@endsection