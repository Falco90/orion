use core::traits::Into;
use core::option::OptionTrait;
use array::ArrayTrait;
use array::SpanTrait;
use traits::{TryInto};

use orion::numbers::signed_integer::i8::i8;
use orion::numbers::fixed_point::core::{FixedType, FixedTrait};
use orion::numbers::fixed_point::implementations::impl_16x16::{
    FP16x16Impl, FP16x16Add, FP16x16Sub, FP16x16Mul, FP16x16Div, FP16x16PartialOrd, FP16x16TryIntoI8
};
use orion::operators::tensor::helpers::broadcast_shape;
use orion::operators::tensor::core::{Tensor, TensorTrait, unravel_index};
use orion::operators::tensor::helpers::{broadcast_index_mapping, len_from_shape, };
use orion::operators::tensor::implementations::impl_tensor_fp::Tensor_fp;
use orion::operators::tensor::implementations::impl_tensor_i8::Tensor_i8;

use orion::utils::saturate;

/// Adds two `Tensor<FixedType>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<FixedType>` instance representing the result of the element-wise addition with broadcasting.
fn add(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<FixedType> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result.append(*(*self.data)[indices_self] + *(*other.data)[indices_other]);

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<FixedType>::new(broadcasted_shape, result.span(), *self.extra);
}

/// Performs element-wise addition of two `Tensor<FixedType>` instances with broadcasting and saturation [-128;127].
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shapes of the tensors are not compatible.
/// * Panics if the gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<i8>` instance representing the result of the element-wise addition with broadcasting and saturation.
fn saturated_add_i8(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<i8> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result
            .append(
                saturate(
                    FixedTrait::new_unscaled(128, true),
                    FixedTrait::new_unscaled(127, false),
                    *(*self.data)[indices_self] + *(*other.data)[indices_other]
                )
                    .try_into()
                    .unwrap()
            );

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<i8>::new(broadcasted_shape, result.span(), *self.extra);
}

/// Subtracts two `Tensor<FixedType>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<FixedType>` instance representing the result of the element-wise subtraction with broadcasting.
fn sub(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<FixedType> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result.append(*(*self.data)[indices_self] - *(*other.data)[indices_other]);

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<FixedType>::new(broadcasted_shape, result.span(), *self.extra);
}

/// Performs element-wise substraction of two `Tensor<FixedType>` instances with broadcasting and saturation [-128;127].
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shapes of the tensors are not compatible.
/// * Panics if the gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<i8>` instance representing the result of the element-wise substraction with broadcasting and saturation.
fn saturated_sub_i8(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<i8> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result
            .append(
                saturate(
                    FixedTrait::new_unscaled(128, true),
                    FixedTrait::new_unscaled(127, false),
                    *(*self.data)[indices_self] - *(*other.data)[indices_other]
                )
                    .try_into()
                    .unwrap()
            );

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<i8>::new(broadcasted_shape, result.span(), *self.extra);
}


/// Multiplies two `Tensor<FixedType>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<FixedType>` instance representing the result of the element-wise multiplication with broadcasting.
fn mul(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<FixedType> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result.append(*(*self.data)[indices_self] * *(*other.data)[indices_other]);

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<FixedType>::new(broadcasted_shape, result.span(), *self.extra);
}

/// Performs element-wise multiplication of two `Tensor<FixedType>` instances with broadcasting and saturation [-128;127].
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shapes of the tensors are not compatible.
/// * Panics if the gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<i8>` instance representing the result of the element-wise multiplication with broadcasting and saturation.
fn saturated_mul_i8(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<i8> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result
            .append(
                saturate(
                    FixedTrait::new_unscaled(128, true),
                    FixedTrait::new_unscaled(127, false),
                    *(*self.data)[indices_self] * *(*other.data)[indices_other]
                )
                    .try_into()
                    .unwrap()
            );

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<i8>::new(broadcasted_shape, result.span(), *self.extra);
}

/// Divides two `Tensor<FixedType>` instances element-wise with broadcasting.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shape of tensors are not compatible. 
/// * Panics if gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<FixedType>` instance representing the result of the element-wise division with broadcasting.
fn div(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<FixedType> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result.append(*(*self.data)[indices_self] / *(*other.data)[indices_other]);

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<FixedType>::new(broadcasted_shape, result.span(), *self.extra);
}

/// Performs element-wise division of two `Tensor<FixedType>` instances with broadcasting and saturation.
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
/// * `min` - The minimum value for saturation.
/// * `max` - The maximum value for saturation.
///
/// # Panics
/// * Panics if the shapes of the tensors are not compatible.
/// * Panics if the gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<FixedType>` instance representing the result of the element-wise division with broadcasting and saturation.
fn saturated_div(
    self: @Tensor<FixedType>, other: @Tensor<FixedType>, min: FixedType, max: FixedType
) -> Tensor<FixedType> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result
            .append(
                saturate(min, max, *(*self.data)[indices_self] / *(*other.data)[indices_other])
            );

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<FixedType>::new(broadcasted_shape, result.span(), *self.extra);
}

/// Performs element-wise division of two `Tensor<FixedType>` instances with broadcasting and saturation [-128;127].
///
/// # Arguments
/// * `self` - The first tensor.
/// * `other` - The second tensor.
///
/// # Panics
/// * Panics if the shapes of the tensors are not compatible.
/// * Panics if the gas limit is exceeded during execution.
///
/// # Returns
/// * A `Tensor<i8>` instance representing the result of the element-wise division with broadcasting and saturation.
fn saturated_div_i8(self: @Tensor<FixedType>, other: @Tensor<FixedType>) -> Tensor<i8> {
    let broadcasted_shape = broadcast_shape(*self.shape, *other.shape);
    let mut result = ArrayTrait::new();

    let num_elements = len_from_shape(broadcasted_shape);

    let mut n: usize = 0;
    loop {
        let indices_broadcasted = unravel_index(n, broadcasted_shape);

        let indices_self = broadcast_index_mapping(*self.shape, indices_broadcasted);
        let indices_other = broadcast_index_mapping(*other.shape, indices_broadcasted);

        result
            .append(
                saturate(
                    FixedTrait::new_unscaled(128, true),
                    FixedTrait::new_unscaled(127, false),
                    *(*self.data)[indices_self] / *(*other.data)[indices_other]
                )
                    .try_into()
                    .unwrap()
            );

        n += 1;
        if n == num_elements {
            break ();
        };
    };

    return TensorTrait::<i8>::new(broadcasted_shape, result.span(), *self.extra);
}
