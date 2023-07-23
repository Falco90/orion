// ===== 1D ===== //

#[cfg(test)]
mod tensor_1D {
    use array::SpanTrait;
    use array::{ArrayTrait};

    use orion::operators::tensor::implementations::impl_tensor_i32::Tensor_i32;
    use orion::numbers::signed_integer::{integer_trait::IntegerTrait, i32::i32};
    use orion::operators::tensor::core::{TensorTrait, ExtraParams};

    #[test]
    #[available_gas(2000000000000)]
    fn tensor_logical_xor() {
        let mut sizes = ArrayTrait::new();
        sizes.append(3);

        let mut arr_1 = ArrayTrait::<i32>::new();
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(1, false));

        let mut arr_2 = ArrayTrait::<i32>::new();
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(1, false));
        arr_2.append(IntegerTrait::new(1, true));

        let extra = Option::<ExtraParams>::None(());

        let tensor_a = TensorTrait::<i32>::new(sizes.span(), arr_1.span(), extra);
        let tensor_b = TensorTrait::<i32>::new(sizes.span(), arr_2.span(), extra);

        let result_a = tensor_a.logical_xor(@tensor_b);
        assert(*result_a.data[0] == 0, 'result[0] = 0'); // 0 ^ 0 false;
        assert(*result_a.data[1] == 1, 'result[1] = 1'); // 0 ^ 1 true;
        assert(*result_a.data[2] == 0, 'result[2] = 0'); // 1 ^ 1 false;

        assert(result_a.data.len() == tensor_a.data.len(), 'tensor length mismatch');
    }
}

// ===== 2D ===== //

#[cfg(test)]
mod tensor_2D {
    use array::SpanTrait;
    use array::{ArrayTrait};

    use orion::operators::tensor::implementations::impl_tensor_i32::Tensor_i32;
    use orion::numbers::signed_integer::{integer_trait::IntegerTrait, i32::i32};
    use orion::operators::tensor::core::{TensorTrait, ExtraParams};


    #[test]
    #[available_gas(200000000000)]
    fn tensor_logical_xor() {
        let mut sizes = ArrayTrait::new();
        sizes.append(3);
        sizes.append(3);

        let mut arr_1 = ArrayTrait::<i32>::new();
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(1, false));
        arr_1.append(IntegerTrait::new(1, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(1, false));
        arr_1.append(IntegerTrait::new(1, true));
        arr_1.append(IntegerTrait::new(100, false));

        let mut arr_2 = ArrayTrait::<i32>::new();
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(1, false));
        arr_2.append(IntegerTrait::new(1, false));
        arr_2.append(IntegerTrait::new(1, true));
        arr_2.append(IntegerTrait::new(10, true));
        arr_2.append(IntegerTrait::new(5, false));
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(0, false));

        let extra = Option::<ExtraParams>::None(());

        let tensor_a = TensorTrait::<i32>::new(sizes.span(), arr_1.span(), extra);
        let tensor_b = TensorTrait::<i32>::new(sizes.span(), arr_2.span(), extra);

        let result_a = tensor_a.logical_xor(@tensor_b);
        assert(*result_a.data[0] == 0, 'result[0] = 0'); // 0 ^ 0: false
        assert(*result_a.data[1] == 1, 'result[1] = 1'); // 0 ^ 1: true
        assert(*result_a.data[2] == 0, 'result[2] = 0'); // 1 ^ 1: false
        assert(*result_a.data[3] == 0, 'result[3] = 0'); // 1 ^ -1: false
        assert(*result_a.data[4] == 1, 'result[4] = 1'); // 0 ^ 10: true
        assert(*result_a.data[5] == 1, 'result[5] = 1'); // 0 ^ 5: true
        assert(*result_a.data[6] == 1, 'result[6] = 1'); // 1 ^ 0: true
        assert(*result_a.data[7] == 1, 'result[7] = 1'); // -1 ^ 0: true
        assert(*result_a.data[8] == 1, 'result[8] = 1'); // 100 ^ 0: true

        assert(result_a.data.len() == tensor_a.data.len(), 'tensor length mismatch');

        let result_b = tensor_b.logical_xor(@tensor_a);
        assert(*result_b.data[0] == 0, 'result[0] = 0'); // 0 ^ 0: false
        assert(*result_b.data[1] == 1, 'result[1] = 1'); // 1 ^ 0: true
        assert(*result_b.data[2] == 0, 'result[2] = 0'); // 1 ^ 1: false
        assert(*result_b.data[3] == 0, 'result[3] = 0'); // -1 ^ 1: false
        assert(*result_b.data[4] == 1, 'result[4] = 1'); // 0 ^ 10: true
        assert(*result_b.data[5] == 1, 'result[5] = 1'); // 5 ^ 0: true
        assert(*result_b.data[6] == 1, 'result[6] = 1'); // 1 ^ 0: true
        assert(*result_b.data[7] == 1, 'result[7] = 1'); // 0 ^ -1: true
        assert(*result_b.data[8] == 1, 'result[8] = 1'); // 0 ^ 100: true

        assert(result_b.data.len() == tensor_a.data.len(), 'tensor length mismatch');
    }

    #[test]
    #[available_gas(200000000000)]
    fn tensor_logical_xor_broadcast() {
        let mut sizes_1 = ArrayTrait::new();
        sizes_1.append(4);
        sizes_1.append(3);

        let mut sizes_2 = ArrayTrait::new();
        sizes_2.append(1);
        sizes_2.append(3);

        let mut arr_1 = ArrayTrait::<i32>::new();
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(1, false));
        arr_1.append(IntegerTrait::new(2, false));
        arr_1.append(IntegerTrait::new(3, false));
        arr_1.append(IntegerTrait::new(4, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(7, false));
        arr_1.append(IntegerTrait::new(8, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(10, false));
        arr_1.append(IntegerTrait::new(11, false));

        let mut arr_2 = ArrayTrait::<i32>::new();
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(1, false));
        arr_2.append(IntegerTrait::new(2, false));

        let extra = Option::<ExtraParams>::None(());

        let tensor_a = TensorTrait::<i32>::new(sizes_1.span(), arr_1.span(), extra);
        let tensor_b = TensorTrait::<i32>::new(sizes_2.span(), arr_2.span(), extra);

        let result_a = tensor_b.logical_xor(@tensor_a);
        assert(*result_a.data[0] == 0, 'result[0] = 0'); // 0 ^ 0: false
        assert(*result_a.data[1] == 0, 'result[1] = 0'); // 1 ^ 1: false
        assert(*result_a.data[2] == 0, 'result[2] = 0'); // 2 ^ 2: false
        assert(*result_a.data[3] == 1, 'result[3] = 1'); // 3 ^ 0: true
        assert(*result_a.data[4] == 0, 'result[4] = 0'); // 4 ^ 1: false
        assert(*result_a.data[5] == 1, 'result[5] = 1'); // 0 ^ 2: true
        assert(*result_a.data[6] == 0, 'result[6] = 0'); // 0 ^ 0: false
        assert(*result_a.data[7] == 0, 'result[7] = 0'); // 7 ^ 1: false
        assert(*result_a.data[8] == 0, 'result[8] = 0'); // 8 ^ 2: false
        assert(*result_a.data[9] == 0, 'result[9] = 0'); // 0 ^ 0: false
        assert(*result_a.data[10] == 0, 'result[10] = 0'); // 10 ^ 1: false
        assert(*result_a.data[11] == 0, 'result[11] = 0'); // 11 ^ 2: false

        assert(result_a.data.len() == tensor_a.data.len(), 'tensor length mismatch');

        let result_b = tensor_a.logical_xor(@tensor_b);
        assert(*result_b.data[0] == 0, 'result[0] = 0'); // 0 ^ 0: false
        assert(*result_b.data[1] == 0, 'result[1] = 0'); // 1 ^ 1: false
        assert(*result_b.data[2] == 0, 'result[2] = 0'); // 2 ^ 2: false
        assert(*result_b.data[3] == 1, 'result[3] = 1'); // 0 ^ 3: true
        assert(*result_b.data[4] == 0, 'result[4] = 0'); // 1 ^ 4: false
        assert(*result_b.data[5] == 1, 'result[5] = 1'); // 2 ^ 0: true
        assert(*result_b.data[6] == 0, 'result[6] = 0'); // 0 ^ 0: false
        assert(*result_b.data[7] == 0, 'result[7] = 0'); // 1 ^ 7: false
        assert(*result_b.data[8] == 0, 'result[8] = 0'); // 2 ^ 8: false
        assert(*result_b.data[9] == 0, 'result[9] = 0'); // 0 ^ 0: false
        assert(*result_b.data[10] == 0, 'result[10] = 0'); // 1 ^ 10: false
        assert(*result_b.data[11] == 0, 'result[11] = 0'); // 2 ^ 11: false

        assert(result_b.data.len() == tensor_a.data.len(), 'tensor length mismatch');
    }
}


// // ===== 3D ===== //

#[cfg(test)]
mod tensor_3D {
    use array::SpanTrait;
    use array::{ArrayTrait};

    use orion::operators::tensor::implementations::impl_tensor_i32::Tensor_i32;
    use orion::numbers::signed_integer::{integer_trait::IntegerTrait, i32::i32};
    use orion::operators::tensor::core::{TensorTrait, ExtraParams};

    #[test]
    #[available_gas(2000000000000)]
    fn tensor_logical_xor() {
        let mut sizes = ArrayTrait::new();
        sizes.append(2);
        sizes.append(2);
        sizes.append(2);

        let mut arr_1 = ArrayTrait::<i32>::new();
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(1, false));
        arr_1.append(IntegerTrait::new(2, false));
        arr_1.append(IntegerTrait::new(3, false));
        arr_1.append(IntegerTrait::new(4, false));
        arr_1.append(IntegerTrait::new(5, false));
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(7, false));

        let mut arr_2 = ArrayTrait::<i32>::new();
        arr_2.append(IntegerTrait::new(10, false));
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(2, true));
        arr_2.append(IntegerTrait::new(0, true));
        arr_2.append(IntegerTrait::new(4, false));
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(16, false));
        arr_2.append(IntegerTrait::new(17, false));

        let extra = Option::<ExtraParams>::None(());

        let tensor_a = TensorTrait::<i32>::new(sizes.span(), arr_1.span(), extra);
        let tensor_b = TensorTrait::<i32>::new(sizes.span(), arr_2.span(), extra);

        let result_a = tensor_a.logical_xor(@tensor_b);
        assert(*result_a.data[0] == 1, 'result[0] = 1'); // 0 ^ 10: true
        assert(*result_a.data[1] == 1, 'result[1] = 1'); // 1 ^ 0: true
        assert(*result_a.data[2] == 0, 'result[2] = 0'); // 2 ^ -2: false
        assert(*result_a.data[3] == 1, 'result[3] = 1'); // 3 ^ -0: true
        assert(*result_a.data[4] == 0, 'result[4] = 0'); // 4 ^ 4: false
        assert(*result_a.data[5] == 1, 'result[5] = 1'); // 5 ^ 0: true
        assert(*result_a.data[6] == 1, 'result[6] = 1'); // 0 ^ 16: true
        assert(*result_a.data[7] == 0, 'result[7] = 0'); // 7 ^ 17: false

        assert(result_a.data.len() == tensor_a.data.len(), 'tensor length mismatch');

        let result_b = tensor_b.logical_xor(@tensor_a);
        assert(*result_b.data[0] == 1, 'result[0] = 1'); // 10 ^ 0: true
        assert(*result_b.data[1] == 1, 'result[1] = 1'); // 0 ^ 1: true
        assert(*result_b.data[2] == 0, 'result[2] = 0'); // -2 ad 2: false
        assert(*result_b.data[3] == 1, 'result[3] = 1'); // -0 ^ 3: true
        assert(*result_b.data[4] == 0, 'result[4] = 0'); // 4 ^ 4: false
        assert(*result_b.data[5] == 1, 'result[5] = 1'); // 0 ^ 5: true
        assert(*result_b.data[6] == 1, 'result[6] = 1'); // 16 ^ 0: true
        assert(*result_b.data[7] == 0, 'result[7] = 0'); // 17 ^ 7: false

        assert(result_b.data.len() == tensor_a.data.len(), 'tensor length mismatch');
    }

    #[test]
    #[available_gas(2000000000000)]
    fn tensor_logical_xor_broadcast() {
        let mut sizes_1 = ArrayTrait::new();
        sizes_1.append(2);
        sizes_1.append(2);
        sizes_1.append(2);

        let mut sizes_2 = ArrayTrait::new();
        sizes_2.append(1);
        sizes_2.append(2);
        sizes_2.append(1);

        let mut arr_1 = ArrayTrait::<i32>::new();
        arr_1.append(IntegerTrait::new(0, false));
        arr_1.append(IntegerTrait::new(1, false));
        arr_1.append(IntegerTrait::new(2, false));
        arr_1.append(IntegerTrait::new(3, false));
        arr_1.append(IntegerTrait::new(4, false));
        arr_1.append(IntegerTrait::new(5, false));
        arr_1.append(IntegerTrait::new(6, false));
        arr_1.append(IntegerTrait::new(7, false));

        let mut arr_2 = ArrayTrait::<i32>::new();
        arr_2.append(IntegerTrait::new(0, false));
        arr_2.append(IntegerTrait::new(1, false));

        let extra = Option::<ExtraParams>::None(());

        let tensor_a = TensorTrait::<i32>::new(sizes_1.span(), arr_1.span(), extra);
        let tensor_b = TensorTrait::<i32>::new(sizes_2.span(), arr_2.span(), extra);

        let result_a = tensor_b.logical_xor(@tensor_a);
        assert(*result_a.data[0] == 0, 'result[0] = 0'); // 0 ^ 0: false
        assert(*result_a.data[1] == 0, 'result[1] = 0'); // 1 ^ 1: false
        assert(*result_a.data[2] == 1, 'result[2] = 1'); // 2 ^ 0: true
        assert(*result_a.data[3] == 0, 'result[3] = 0'); // 3 ^ 1: false
        assert(*result_a.data[4] == 1, 'result[4] = 1'); // 4 ^ 0: true
        assert(*result_a.data[5] == 0, 'result[5] = 0'); // 5 ^ 1: false
        assert(*result_a.data[6] == 1, 'result[6] = 1'); // 6 ^ 0: true
        assert(*result_a.data[7] == 0, 'result[7] = 0'); // 7 ^ 1: false

        assert(result_a.data.len() == tensor_a.data.len(), 'tensor length mismatch');

        let result_b = tensor_a.logical_xor(@tensor_b);
        assert(*result_b.data[0] == 0, 'result[0] = 0'); // 0 ^ 0: false
        assert(*result_b.data[1] == 0, 'result[1] = 0'); // 1 ^ 1: false
        assert(*result_b.data[2] == 1, 'result[2] = 1'); // 0 ^ 2: true
        assert(*result_b.data[3] == 0, 'result[3] = 0'); // 1 ^ 3: false
        assert(*result_b.data[4] == 1, 'result[4] = 1'); // 0 ^ 4: true
        assert(*result_b.data[5] == 0, 'result[5] = 0'); // 1 ^ 5: false
        assert(*result_b.data[6] == 1, 'result[6] = 1'); // 0 ^ 6: true
        assert(*result_b.data[7] == 0, 'result[7] = 0'); // 1 ^ 7: false

        assert(result_b.data.len() == tensor_a.data.len(), 'tensor length mismatch');
    }
}
