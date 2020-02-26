staload UN = "prelude/SATS/unsafe.sats"

// from here: https://docs.microsoft.com/en-us/openspecs/office_protocols/ms-abs/06966aa2-70da-4bf9-8448-3355f277cd77?redirectedfrom=MSDN
fn byteview_read_as_char {l0:addr}{m:nat}{ l1 : addr | l1 <= l0+m }(pf : !bytes_v(l0, m) | p : ptr(l1)) : uint8 =
  $UN.ptr0_get<uint8>(p)

implement crc32(pf | p, l) =
    let val crc32_start = 0xFFFFFFFFu
    in crc32_start end
