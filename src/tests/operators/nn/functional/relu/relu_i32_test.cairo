// ===== 1D ===== //

#[cfg(test)]
mod input_1D {
    use array::ArrayTrait;
    use array::SpanTrait;
    use traits::Into;

    use orion::operators::tensor::core::{TensorTrait, ExtraParams};
    use orion::operators::tensor::implementations::impl_tensor_i32::Tensor_i32;
    use orion::numbers::signed_integer::{integer_trait::IntegerTrait, i32::i32};
    use orion::operators::nn::core::NNTrait;
    use orion::operators::nn::implementations::impl_nn_i32::NN_i32;

    #[test]
    #[available_gas(2000000)]
    fn relu() {
        let mut shape = ArrayTrait::<usize>::new();
        shape.append(4);

        let mut data = ArrayTrait::<i32>::new();
        let val_1 = IntegerTrait::new(1, false);
        let val_2 = IntegerTrait::new(2, false);
        let val_3 = IntegerTrait::new(1, true);
        let val_4 = IntegerTrait::new(2, true);

        data.append(val_1);
        data.append(val_2);
        data.append(val_3);
        data.append(val_4);

        let extra = Option::<ExtraParams>::None(());

        let mut tensor = TensorTrait::new(shape.span(), data.span(), extra);
        let threshold = IntegerTrait::new(0, false);

        let mut result = NNTrait::relu(@tensor, threshold);

        let data_0 = *result.data[0];
        assert((*result.data[0]).into() == 1, 'result[0] == 1');
        assert((*result.data[3]).into() == 0, 'result[3] == 0');
    }
}

// ===== 2D ===== //

#[cfg(test)]
mod input_2D {
    use array::ArrayTrait;
    use array::SpanTrait;
    use traits::Into;

    use orion::operators::tensor::core::{TensorTrait, ExtraParams};
    use orion::operators::tensor::implementations::impl_tensor_i32::Tensor_i32;
    use orion::numbers::signed_integer::{integer_trait::IntegerTrait, i32::i32};
    use orion::operators::nn::core::NNTrait;
    use orion::operators::nn::implementations::impl_nn_i32::NN_i32;

    #[test]
    #[available_gas(2000000)]
    fn relu() {
        let mut shape = ArrayTrait::<usize>::new();
        shape.append(2);
        shape.append(2);

        let mut data = ArrayTrait::<i32>::new();
        let val_1 = IntegerTrait::new(1, false);
        let val_2 = IntegerTrait::new(2, false);
        let val_3 = IntegerTrait::new(1, true);
        let val_4 = IntegerTrait::new(2, true);

        data.append(val_1);
        data.append(val_2);
        data.append(val_3);
        data.append(val_4);

        let extra = Option::<ExtraParams>::None(());

        let mut tensor = TensorTrait::new(shape.span(), data.span(), extra);
        let threshold = IntegerTrait::new(0, false);

        let mut result = NNTrait::relu(@tensor, threshold);

        let data_0 = *result.data[0];
        assert((*result.data[0]).into() == 1, 'result[0] == 1');
        assert((*result.data[3]).into() == 0, 'result[3] == 0');
    }
}

// ===== 3D ===== //

#[cfg(test)]
mod input_3D {
    use array::ArrayTrait;
    use array::SpanTrait;
    use traits::Into;

    use orion::operators::tensor::core::{TensorTrait, ExtraParams};
    use orion::operators::tensor::implementations::impl_tensor_i32::Tensor_i32;
    use orion::numbers::signed_integer::{integer_trait::IntegerTrait, i32::i32};
    use orion::operators::nn::core::NNTrait;
    use orion::operators::nn::implementations::impl_nn_i32::NN_i32;

    #[test]
    #[available_gas(2000000)]
    fn relu() {
        let mut shape = ArrayTrait::<usize>::new();
        shape.append(2);
        shape.append(2);
        shape.append(2);

        let mut data = ArrayTrait::<i32>::new();
        let val_1 = IntegerTrait::new(1, false);
        let val_2 = IntegerTrait::new(2, false);
        let val_3 = IntegerTrait::new(1, true);
        let val_4 = IntegerTrait::new(2, true);
        let val_5 = IntegerTrait::new(1, false);
        let val_6 = IntegerTrait::new(2, false);
        let val_7 = IntegerTrait::new(1, true);
        let val_8 = IntegerTrait::new(2, true);

        data.append(val_1);
        data.append(val_2);
        data.append(val_3);
        data.append(val_4);
        data.append(val_5);
        data.append(val_6);
        data.append(val_7);
        data.append(val_8);

        let extra = Option::<ExtraParams>::None(());

        let mut tensor = TensorTrait::new(shape.span(), data.span(), extra);
        let threshold = IntegerTrait::new(0, false);

        let mut result = NNTrait::relu(@tensor, threshold);

        let data_0 = *result.data[0];
        assert((*result.data[0]).into() == 1, 'result[0] == 1');
        assert((*result.data[3]).into() == 0, 'result[3] == 0');
        assert((*result.data[5]).into() == 2, 'result[6] == 2');
    }
}
