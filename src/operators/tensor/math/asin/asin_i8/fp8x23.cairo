use array::ArrayTrait;
use array::SpanTrait;
use option::OptionTrait;
use traits::Into;

use orion::numbers::fixed_point::core::{FixedTrait, FixedType};
use orion::operators::tensor::core::{Tensor, TensorTrait};
use orion::numbers::signed_integer::i8::i8;
use orion::operators::tensor::implementations::impl_tensor_fp::Tensor_fp;
use orion::numbers::fixed_point::implementations::impl_8x23::FP8x23Impl;


/// Cf: TensorTrait::asin docstring
fn asin(self: @Tensor<i8>) -> Tensor<FixedType> {
    let mut result = ArrayTrait::new();
    let mut data = *self.data;

    loop {
        let ele = *data.pop_front().unwrap();

        if ele.sign == true {
            let ele = FixedTrait::new_unscaled(ele.mag.into(), ele.sign);
            result.append(FixedTrait::asin(ele))
        } else {
            let ele = FixedTrait::new_unscaled(ele.mag.into(), ele.sign);
            result.append(FixedTrait::asin(ele))
        }

        if (data.len() == 0) {
            break ();
        };
    };

    return TensorTrait::<FixedType>::new(*self.shape, result.span(), *self.extra);
}
