@extends('layouts.master')
@section('main-content')
@section('page-css')
<link rel="stylesheet" href="{{asset('assets/styles/vendor/nprogress.css')}}">
<link rel="stylesheet" href="{{asset('assets/styles/vendor/dropzone.min.css')}}">
@endsection

<div class="breadcrumb">
    <h1>{{ __('translate.Edit_Product') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_edit_product">
    <div class="col-lg-12 mb-3">
        <!--begin::form-->
        <form @submit.prevent="Update_Product()" enctype="multipart/form-data">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <!-- Product Type -->
                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Product_Type') }} <span class="field_required">*</span></label>
                            <v-select placeholder="{{ __('translate.Choose_Type') }}" v-model="product.type"
                                :reduce="(option) => option.value" :options="
                                    [
                                        {label: 'Standard Product', value: 'is_single'},
                                        {label: 'Variable Product', value: 'is_variant'},
                                        {label: 'Service', value: 'is_service'},
                                        {label: 'Stitched Garment', value: 'stitched_garment'},
                                        {label: 'Unstitched Garment', value: 'unstitched_garment'}
                                    ]" @input="onTypeChange">
                            </v-select>
                            <span class="error" v-if="errors && errors.type">
                                @{{ errors.type[0] }}
                            </span>
                        </div>

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
                            <div class="input-group mb-3">
                                <input v-model="product.code" type="text" class="form-control" placeholder="generate the barcode" aria-describedby="basic-addon2">
                                <span class="input-group-text cursor-pointer" id="basic-addon2" @click="generateNumber()"><i class="i-Bar-Code"></i></span>
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
                            <label>{{ __('translate.Brand') }}</label>
                            <v-select placeholder="{{ __('translate.Choose_Brand') }}" v-model="product.brand_id"
                                :reduce="(option) => option.value"
                                :options="brands.map(brands => ({label: brands.name, value: brands.id}))" @input="Selected_Brand">
                            </v-select>
                        </div>

                        <div class="form-group col-md-4">
                            <label for="TaxNet">{{ __('translate.Order_Tax') }}</label>
                            <div class="input-group mb-3">
                                <input v-model.number="product.TaxNet" type="text" class="form-control" aria-describedby="basic-addon3">
                                <span class="input-group-text cursor-pointer" id="basic-addon3">%</span>
                            </div>
                        </div>

                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Tax_Method') }} <span class="field_required">*</span></label>
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

                        <!-- Main Image -->
                        <div class="form-group col-md-4">
                            <label for="image">{{ __('translate.Image') }}</label>
                            <input name="image" @change="onFileSelected" type="file" class="form-control" id="image">
                            <div v-if="product.image && product.image != 'no_image.png'" class="mt-2">
                                <img :src="'/images/products/' + product.image" width="80" height="80" class="img-thumbnail">
                            </div>
                            <span class="error" v-if="errors && errors.image">
                                @{{ errors.image[0] }}
                            </span>
                        </div>

                        <!-- Multiple Images -->
                        <div class="form-group col-md-12">
                            <label>{{ __('Multiple Images') }}</label>
                            <div class="dropzone" id="dropzone-multiple">
                                <div class="fallback">
                                    <input name="multiple_images[]" type="file" multiple id="multiple_images" @change="onMultipleFilesSelected">
                                </div>
                            </div>
                            <div class="row mt-3" v-if="product.existing_images && product.existing_images.length > 0">
                                <div class="col-md-2 mb-2" v-for="(image, index) in product.existing_images" :key="index">
                                    <div class="card">
                                        <img :src="'/images/products/multiple/' + image.image" class="card-img-top" style="height: 100px; object-fit: cover;">
                                        <div class="card-body p-2 text-center">
                                            <button type="button" @click="removeExistingImage(image.id)" class="btn btn-danger btn-sm">
                                                <i class="i-Close-Window"></i> {{ __('Remove') }}
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-md-12 mb-4">
                            <label for="note">{{ __('translate.Please_provide_any_details') }}</label>
                            <textarea type="text" v-model="product.note" class="form-control" name="note" id="note"
                                placeholder="{{ __('translate.Please_provide_any_details') }}"></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stitched Garment Fields -->
            <div class="card mt-5" v-if="product.type == 'stitched_garment'">
                <div class="card-header">
                    <h4>{{ __('Stitched Garment Details') }}</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label>{{ __('Garment Type') }} <span class="field_required">*</span></label>
                            <v-select v-model="product.garment_type" :reduce="option => option.value" :options="[
                                {label: 'Shirt/Suit', value: 'shirt_suit'},
                                {label: 'Pant/Shalwar', value: 'pant_shalwar'}
                            ]" placeholder="Select Garment Type"></v-select>
                        </div>

                        <!-- Shirt/Suit Measurements -->
                        <div class="col-md-12" v-if="product.garment_type == 'shirt_suit'">
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <h5>{{ __('Shirt/Suit Measurements') }}</h5>
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Length') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_length">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Shoulder') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_shoulder">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Sleeves') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_sleeves">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Chest') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_chest">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Upper Waist') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_upper_waist">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Lower Waist') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_lower_waist">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Hip') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_hip">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Neck') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_neck">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Arms') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_arms">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Cuff') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_cuff">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Biceps') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.shirt_biceps">
                                </div>
                                
                                <div class="col-md-12 mt-3">
                                    <h6>{{ __('Collar Types') }}</h6>
                                    <div class="row">
                                        <div class="form-group col-md-2">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" v-model="product.collar_shirt" id="collar_shirt">
                                                <label class="form-check-label" for="collar_shirt">
                                                    {{ __('Shirt Collar') }}
                                                </label>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group col-md-2">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" v-model="product.collar_sherwani" id="collar_sherwani">
                                                <label class="form-check-label" for="collar_sherwani">
                                                    {{ __('Sherwani Collar') }}
                                                </label>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group col-md-2">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" v-model="product.collar_damian" id="collar_damian">
                                                <label class="form-check-label" for="collar_damian">
                                                    {{ __('Damian Collar') }}
                                                </label>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group col-md-2">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" v-model="product.collar_round" id="collar_round">
                                                <label class="form-check-label" for="collar_round">
                                                    {{ __('Round Collar') }}
                                                </label>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group col-md-2">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" v-model="product.collar_square" id="collar_square">
                                                <label class="form-check-label" for="collar_square">
                                                    {{ __('Square Collar') }}
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pant/Shalwar Measurements -->
                        <div class="col-md-12" v-if="product.garment_type == 'pant_shalwar'">
                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <h5>{{ __('Pant/Shalwar Measurements') }}</h5>
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Length') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.pant_length">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Waist') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.pant_waist">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Hip') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.pant_hip">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Thai') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.pant_thai">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Knee') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.pant_knee">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Bottom') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.pant_bottom">
                                </div>
                                
                                <div class="form-group col-md-3">
                                    <label>{{ __('Fly') }}</label>
                                    <input type="number" step="0.01" class="form-control" v-model="product.pant_fly">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Unstitched Garment Fields -->
            <div class="card mt-5" v-if="product.type == 'unstitched_garment'">
                <div class="card-header">
                    <h4>{{ __('Unstitched Garment Details') }}</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label>{{ __('Thaan Length (meters)') }}</label>
                            <input type="number" step="0.01" class="form-control" v-model="product.thaan_length" disabled>
                        </div>
                        
                        <div class="form-group col-md-4">
                            <label>{{ __('Suit Length (meters)') }}</label>
                            <input type="number" step="0.01" class="form-control" v-model="product.suit_length" disabled>
                        </div>
                        
                        <div class="form-group col-md-12">
                            <label>{{ __('Available Sizes') }}</label>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-check form-check-inline" v-for="size in ['XS', 'S', 'M', 'L', 'XL', 'XXL', 'XXXL']" :key="size">
                                        <input class="form-check-input" type="checkbox" :id="'size_' + size" 
                                            :value="size" v-model="product.available_sizes">
                                        <label class="form-check-label" :for="'size_' + size">
                                            @{{ size }}
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pricing Section -->
            <div class="card mt-5">
                <div class="card-body">
                    <div class="row">
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

                        <!-- Promo Section -->
                        <div class="form-group col-md-12">
                            <div class="form-check form-check-inline">
                                <label class="checkbox checkbox-primary" for="is_promo">
                                    <input type="checkbox" id="is_promo" v-model="product.is_promo">
                                    <span>{{ __('translate.Product_Has_Promo') }}</span><span class="checkmark"></span>
                                </label>
                            </div>
                        </div>

                        <div class="row" v-if="product.is_promo">
                            <div class="form-group col-md-4">
                                <label for="promo_price">{{ __('translate.Promo_Price') }}</label>
                                <input type="text" class="form-control" id="promo_price" placeholder="{{ __('translate.Enter_Promo_Price') }}"
                                    v-model="product.promo_price">
                            </div>

                            <div class="form-group col-md-4">
                                <label for="promo_start_date">{{ __('translate.Promo_Start_Date') }}</label>
                                <vuejs-datepicker id="promo_start_date" name="promo_start_date"
                                    v-model="product.promo_start_date" format="yyyy-MM-dd"
                                    input-class="form-control" placeholder="{{ __('translate.Promo_Start_Date') }}">
                                </vuejs-datepicker>
                            </div>

                            <div class="form-group col-md-4">
                                <label for="promo_end_date">{{ __('translate.Promo_End_Date') }}</label>
                                <vuejs-datepicker id="promo_end_date" name="promo_end_date"
                                    v-model="product.promo_end_date" format="yyyy-MM-dd"
                                    input-class="form-control" placeholder="{{ __('translate.Promo_End_Date') }}">
                                </vuejs-datepicker>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Inventory Section -->
            <div class="card mt-5" v-if="product.type != 'is_service'">
                <div class="card-body">
                    <div class="row">
                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Unit_Product') }} <span class="field_required">*</span></label>
                            <v-select @input="Selected_Unit" placeholder="{{ __('translate.Choose_Unit_Product') }}"
                                v-model="product.unit_id" :reduce="label => label.value"
                                :options="units.map(units => ({label: units.name, value: units.id}))">
                            </v-select>
                            <span class="error" v-if="errors && errors.unit_id">
                                @{{ errors.unit_id[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Unit_Sale') }} <span class="field_required">*</span></label>
                            <v-select placeholder="{{ __('translate.Choose_Unit_Sale') }}"
                                v-model="product.unit_sale_id" :reduce="label => label.value"
                                :options="units_sub.map(units_sub => ({label: units_sub.name, value: units_sub.id}))">
                            </v-select>
                            <span class="error" v-if="errors && errors.unit_sale_id">
                                @{{ errors.unit_sale_id[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label>{{ __('translate.Unit_Purchase') }} <span class="field_required">*</span></label>
                            <v-select placeholder="{{ __('translate.Choose_Unit_Purchase') }}"
                                v-model="product.unit_purchase_id" :reduce="label => label.value"
                                :options="units_sub.map(units_sub => ({label: units_sub.name, value: units_sub.id}))">
                            </v-select>
                            <span class="error" v-if="errors && errors.unit_purchase_id">
                                @{{ errors.unit_purchase_id[0] }}
                            </span>
                        </div>

                        <div class="form-group col-md-4">
                            <label for="qty_min">{{ __('translate.Minimum_sale_quantity') }}</label>
                            <input type="text" class="form-control" id="qty_min"
                                placeholder="{{ __('translate.Enter_Minimum_sale_quantity') }}"
                                v-model="product.qty_min">
                        </div>

                        <div class="form-group col-md-4">
                            <label for="stock_alert">{{ __('translate.Stock_Alert') }}</label>
                            <input type="text" class="form-control" id="stock_alert"
                                placeholder="{{ __('translate.Enter_Stock_alert') }}" v-model="product.stock_alert">
                        </div>

                        <!-- Product_Has_Imei_Serial_number -->
                        <div class="form-group col-md-4">
                            <div class="form-check form-check-inline">
                                <label class="checkbox checkbox-primary" for="is_imei">
                                    <input type="checkbox" id="is_imei" v-model="product.is_imei">
                                    <span>{{ __('translate.Product_Has_Imei/Serial_number') }}</span><span class="checkmark"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Variants Section -->
            <div class="card mt-5" v-if="product.type == 'is_variant'">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-9 mb-3">
                            <div class="d-flex">
                                <input placeholder="Enter the Variant" type="text"
                                    name="variant" v-model="tag" class="form-control">
                                <a @click="add_variant(tag)" class="ms-3 btn btn-md btn-primary">
                                    {{ __('translate.Add') }}
                                </a>
                            </div>
                        </div>

                        <div class="col-md-9 mb-2">
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
                                            <td colspan="5">{{ __('translate.No_data_Available') }}</td>
                                        </tr>
                                        <tr v-for="variant in variants">
                                            <td>
                                                <input required class="form-control" v-model="variant.code">
                                                <span class="error" v-if="errors && errors['variants.' + $index + '.code']">
                                                    @{{ errors['variants.' + $index + '.code'][0] }}
                                                </span>
                                            </td>
                                            <td>
                                                <input required class="form-control" v-model="variant.text">
                                                <span class="error" v-if="errors && errors['variants.' + $index + '.text']">
                                                    @{{ errors['variants.' + $index + '.text'][0] }}
                                                </span>
                                            </td>
                                            <td>
                                                <input required class="form-control" v-model="variant.cost">
                                                <span class="error" v-if="errors && errors['variants.' + $index + '.cost']">
                                                    @{{ errors['variants.' + $index + '.cost'][0] }}
                                                </span>
                                            </td>
                                            <td>
                                                <input required class="form-control" v-model="variant.price">
                                                <span class="error" v-if="errors && errors['variants.' + $index + '.price']">
                                                    @{{ errors['variants.' + $index + '.price'][0] }}
                                                </span>
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

            <div class="row mt-3">
                <div class="col-lg-6">
                    <button type="submit" class="btn btn-primary" :disabled="SubmitProcessing">
                        <span v-if="SubmitProcessing" class="spinner-border spinner-border-sm" role="status"
                            aria-hidden="true"></span> <i class="i-Yes me-2 font-weight-bold"></i> {{ __('translate.Submit') }}
                    </button>
                    <a href="/products/products" class="btn btn-danger ml-2">{{ __('translate.Cancel') }}</a>
                </div>
            </div>
        </form>
        <!-- end::form -->
    </div>
</div>

@endsection

@section('page-js')
<script src="{{asset('assets/js/nprogress.js')}}"></script>
<script src="{{asset('assets/js/vendor/vuejs-datepicker/vuejs-datepicker.min.js')}}"></script>
<script src="{{asset('assets/js/vendor/dropzone.min.js')}}"></script>

<script>
    Vue.component('v-select', VueSelect.VueSelect)
    
    var app = new Vue({
        el: '#section_edit_product',
        components: {
            vuejsDatepicker,
        },
        data: {
            len: 8,
            tag: "",
            SubmitProcessing: false,
            data: new FormData(),
            errors: [],
            categories: @json($categories),
            units: @json($units),
            units_sub: @json($units_sub),
            brands: @json($brands),
            product: @json($product),
            variants: @json($product['ProductVariant']),
            removed_images: [], // To track removed multiple images
            multiple_images: [], // To track new multiple images
        },

        methods: {
            //------ Generate code
            generateNumber() {
                this.product.code = Math.floor(
                    Math.pow(10, this.len - 1) +
                    Math.random() *
                        (Math.pow(10, this.len) - Math.pow(10, this.len - 1) - 1)
                );
            },

            Selected_Brand(value) {
                if (value === null) {
                    this.product.brand_id = "";
                }
            },

            onTypeChange() {
                // Reset variant-related fields when type changes
                if (this.product.type !== 'is_variant') {
                    this.variants = [];
                }
                
                // Set default values for unstitched garments
                if (this.product.type === 'unstitched_garment') {
                    this.product.thaan_length = 22.5;
                    this.product.suit_length = 4.5;
                    this.product.available_sizes = this.product.available_sizes || [];
                }
            },

            formatDate(d) {
                if (!d) return '';
                var m1 = d.getMonth() + 1;
                var m2 = m1 < 10 ? '0' + m1 : m1;
                var d1 = d.getDate();
                var d2 = d1 < 10 ? '0' + d1 : d1;
                return [d.getFullYear(), m2, d2].join('-');
            },

            // Handle main image selection
            onFileSelected(e) {
                let file = e.target.files[0];
                this.product.image = file;
            },

            // Handle multiple images selection
            onMultipleFilesSelected(e) {
                this.multiple_images = Array.from(e.target.files);
            },

            // Remove existing multiple image
            removeExistingImage(imageId) {
                this.removed_images.push(imageId);
                // Remove from display
                this.product.existing_images = this.product.existing_images.filter(img => img.id !== imageId);
            },

            //---------------------- Get Sub Units with Unit id ------------------------------\\
            Get_Units_SubBase(value) {
                axios
                    .get("/products/Get_Units_SubBase?id=" + value)
                    .then(({ data }) => (this.units_sub = data));
            },

            //---------------------- Event Select Unit Product ------------------------------\\
            Selected_Unit(value) {
                this.units_sub = [];
                this.product.unit_sale_id = "";
                this.product.unit_purchase_id = "";
                this.Get_Units_SubBase(value);
            },

            // Add variant
            add_variant(tag) {
                if (this.variants.length > 0 && this.variants.some(variant => variant.text === tag)) {
                    toastr.error('Variant Duplicate');
                } else {
                    if (this.tag != '') {
                        var variant_tag = {
                            var_id: this.variants.length + 1,
                            id: 0, // New variant, so ID is 0
                            text: tag,
                            code: '',
                            cost: 0,
                            price: 0,
                            product_id: this.product.id
                        };
                        this.variants.push(variant_tag);
                        this.tag = "";
                    } else {
                        toastr.error('Please Enter the Variant');
                    }
                }
            },

            // Delete variant
            delete_variant(var_id) {
                for (var i = 0; i < this.variants.length; i++) {
                    if (var_id === this.variants[i].var_id) {
                        // If variant has an ID (existing variant), mark for deletion in backend
                        if (this.variants[i].id > 0) {
                            this.variants[i].deleted = true;
                        } else {
                            this.variants.splice(i, 1);
                        }
                        break;
                    }
                }
                // Remove from display if not marked for deletion
                this.variants = this.variants.filter(v => !v.deleted);
            },

            //------------------------------ Update_Product ------------------------------\\
            Update_Product() {
                // Start the progress bar.
                NProgress.start();
                NProgress.set(0.1);
                var self = this;
                self.SubmitProcessing = true;
                self.errors = {};
                
                // Reset FormData
                self.data = new FormData();
                
                // Set is_variant based on type and variants
                if (self.product.type == 'is_variant') {
                    self.product.is_variant = self.variants.length > 0;
                    if (self.variants.length <= 0) {
                        toastr.error('The variants array is required.');
                        NProgress.done();
                        self.SubmitProcessing = false;
                        return;
                    }
                } else {
                    self.product.is_variant = false;
                }

                // append product data
                Object.entries(self.product).forEach(([key, value]) => {
                    if (key === 'promo_start_date' || key === 'promo_end_date') {
                        if (value instanceof Date) {
                            self.data.append(key, self.formatDate(value));
                        } else if (value) {
                            self.data.append(key, value);
                        }
                    } else if (key !== 'existing_images') {
                        self.data.append(key, value);
                    }
                });

                // append variants data
                if (self.product.type == 'is_variant' && self.variants.length > 0) {
                    for (var i = 0; i < self.variants.length; i++) {
                        Object.entries(self.variants[i]).forEach(([key, value]) => {
                            self.data.append("variants[" + i + "][" + key + "]", value);
                        });
                    }
                }

                // append removed images
                if (self.removed_images.length > 0) {
                    self.removed_images.forEach((id, index) => {
                        self.data.append("removed_images[" + index + "]", id);
                    });
                }

                // append new multiple images
                if (self.multiple_images.length > 0) {
                    self.multiple_images.forEach((file, index) => {
                        self.data.append("multiple_images[" + index + "]", file);
                    });
                }

                self.data.append("_method", "put");

                // Send Data with axios
                axios.post("/products/products/" + self.product.id, self.data, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                })
                .then(response => {
                    // Complete the animation of theprogress bar.
                    NProgress.done();
                    self.SubmitProcessing = false;
                    window.location.href = '/products/products'; 
                    toastr.success('{{ __('translate.Updated_in_successfully') }}');
                    self.errors = {};
                })
                .catch(error => {
                    NProgress.done();
                    self.SubmitProcessing = false;

                    if (error.response.status == 422) {
                        self.errors = error.response.data.errors;
                        toastr.error('{{ __('translate.There_was_something_wronge') }}');
                    } else {
                        toastr.error('Something went wrong');
                    }
                });
            }
        },
        
      
        created() {
            // Initialize units_sub if unit_id exists
            if (this.product.unit_id) {
                this.Get_Units_SubBase(this.product.unit_id);
            }
            
            // Format dates if they exist
            if (this.product.promo_start_date) {
                this.product.promo_start_date = new Date(this.product.promo_start_date);
            }
            if (this.product.promo_end_date) {
                this.product.promo_end_date = new Date(this.product.promo_end_date);
            }
            
            // Initialize dropzone for multiple images
            new Dropzone("#dropzone-multiple", {
                url: "/",
                autoProcessQueue: false,
                addRemoveLinks: true,
                dictDefaultMessage: "{{ __('translate.Drop_files_here_or_click_to_upload') }}",
                acceptedFiles: "image/*",
                init: function() {
                    this.on("addedfile", file => {
                        if (!file.type.match('image.*')) {
                            this.removeFile(file);
                            toastr.error('{{ __('translate.File_type_not_allowed') }}');
                        }
                    });
                    this.on("success", (file, response) => {
                        this.removeFile(file);
                    });
                }
            });
            
            // Initialize available_sizes as array if it's a string
            if (this.product.type === 'unstitched_garment' && typeof this.product.available_sizes === 'string') {
                this.product.available_sizes = JSON.parse(this.product.available_sizes);
            }
        }
    })
</script>
@endsection  