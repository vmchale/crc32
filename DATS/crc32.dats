staload UN = "prelude/SATS/unsafe.sats"

fn byteview_read_as_uint8 {l0:addr}{m:nat}{ l1 : addr | l1 <= l0+m }(pf : !bytes_v(l0, m) | p : ptr(l1)) : uint8 =
  $UN.ptr0_get<uint8>(p)

// from here: https://docs.microsoft.com/en-us/openspecs/office_protocols/ms-abs/06966aa2-70da-4bf9-8448-3355f277cd77?redirectedfrom=MSDN
fn crc32 {l:addr}{m:nat}(pf : !bytes_v(l, m) | p : ptr(l), l : size_t(m)) : uint =
  let
    var crc32_start = 0xFFFFFFFFu
    var i: size_t
    val () = for* { i : nat | i <= m } .<m-i>. (i : size_t(i)) =>
        (i := i2sz(0) ; i < l ; i := i + 1)
        let
          var current_byte = $UN.ptr0_get<uint8>(add_ptr_bsz(p, i))
        in end
  in
    g0uint_lxor_uint(crc32_start, 0xFFFFFFFFu)
  end
