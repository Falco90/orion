// ===== 1D ===== //

#[cfg(test)]
mod tensor_1D {
    use array::SpanTrait;
    use traits::Into;
    use array::ArrayTrait;

    use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
    use orion::operators::tensor::core::{TensorTrait, Tensor, ExtraParams};

    #[test]
    #[available_gas(20000000)]
    fn tensor_ln_test() {
        let mut sizes = ArrayTrait::new();
        sizes.append(4);

        let mut data = ArrayTrait::new();
        data.append(1);
        data.append(2);
        data.append(3);
        data.append(100);
        let extra = Option::<ExtraParams>::None(());
        let tensor = TensorTrait::<u32>::new(sizes.span(), data.span(), extra);

        let result = tensor.ln().data;

        assert((*result.at(0).mag).into() == 0, 'result[0] = 0');
        assert((*result.at(1).mag).into() == 45355, 'result[1] = 0.69315');
        assert((*result.at(2).mag).into() == 71992, 'result[2] = 1.0986');
        assert((*result.at(3).mag).into() == 301793, 'result[3] = 4.60517');
    }
}

// ===== 2D ===== //

mod tensor_2D {
    use array::SpanTrait;
    use traits::Into;
    use array::ArrayTrait;

    use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
    use orion::operators::tensor::core::{TensorTrait, Tensor, ExtraParams};

    #[test]
    #[available_gas(20000000)]
    fn tensor_ln_test() {
        let mut sizes = ArrayTrait::new();
        sizes.append(2);
        sizes.append(2);

        let mut data = ArrayTrait::new();
        data.append(1);
        data.append(2);
        data.append(3);
        data.append(100);
        let extra = Option::<ExtraParams>::None(());
        let tensor = TensorTrait::<u32>::new(sizes.span(), data.span(), extra);

        let result = tensor.ln().data;

        assert((*result.at(0).mag).into() == 0, 'result[0] = 0');
        assert((*result.at(1).mag).into() == 45355, 'result[1] = 0.69315');
        assert((*result.at(2).mag).into() == 71992, 'result[2] = 1.0986');
        assert((*result.at(3).mag).into() == 301793, 'result[3] = 4.60517');
    }
}
// // ===== 3D ===== //

mod tensor_3D {
    use array::SpanTrait;
    use traits::Into;
    use array::ArrayTrait;

    use orion::operators::tensor::implementations::impl_tensor_u32::Tensor_u32;
    use orion::operators::tensor::core::{TensorTrait, Tensor, ExtraParams};

    #[test]
    #[available_gas(20000000)]
    fn tensor_ln_test() {
        let mut sizes = ArrayTrait::new();
        sizes.append(2);
        sizes.append(2);
        sizes.append(2);

        let mut data = ArrayTrait::new();
        data.append(1);
        data.append(2);
        data.append(3);
        data.append(100);
        data.append(3);
        data.append(100);
        data.append(3);
        data.append(100);
        let extra = Option::<ExtraParams>::None(());
        let tensor = TensorTrait::<u32>::new(sizes.span(), data.span(), extra);

        let result = tensor.ln().data;

        assert((*result.at(0).mag).into() == 0, 'result[0] = 0');
        assert((*result.at(1).mag).into() == 45355, 'result[1] = 0.69315');
        assert((*result.at(2).mag).into() == 71992, 'result[2] = 1.0986');
        assert((*result.at(3).mag).into() == 301793, 'result[3] = 4.60517');
        assert((*result.at(4).mag).into() == 71992, 'result[4] = 1.0986');
        assert((*result.at(5).mag).into() == 301793, 'result[5] = 4.60517');
        assert((*result.at(6).mag).into() == 71992, 'result[6] = 1.0986');
        assert((*result.at(7).mag).into() == 301793, 'result[7] = 4.60517');
    }
}

