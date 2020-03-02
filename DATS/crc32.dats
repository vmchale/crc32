staload UN = "prelude/SATS/unsafe.sats"

#include "DATS/array.dats"

fn byteview_read_as_uint8 {l0:addr}{m:nat}{ l1 : addr | l1 <= l0+m }(pf : !bytes_v(l0, m) | p : ptr(l1)) : uint8 =
  $UN.ptr0_get<uint8>(p)

extern
castfn uint2uint8(uint32) : uint8

extern
castfn uint2uint32(uint) : uint32

extern
castfn witness(uint8) : [ i : nat | i >= 0 && i < 256 ] uint8(i)

// from here: https://docs.microsoft.com/en-us/openspecs/office_protocols/ms-abs/06966aa2-70da-4bf9-8448-3355f277cd77?redirectedfrom=MSDN
fn crc32 {l:addr}{m:nat}(pf : !bytes_v(l, m) | p : ptr(l), l : size_t(m)) : uint32 =
  let
    var crc32: uint32 = uint2uint32(0xFFFFFFFFu)
    var i: size_t
    val () = for* { i : nat | i <= m } .<m-i>. (i : size_t(i)) =>
        (i := i2sz(0) ; i < l ; i := i + 1)
        let
          var current_byte = $UN.ptr0_get<uint8>(add_ptr_bsz(p, i))
          var crc_trunc = uint2uint8(crc32)
          var ix = witness(g0uint_lxor_uint8(crc_trunc, current_byte))
          var crc_shift = g0uint_lsr(crc32, 8)
          val lookup = array_get_at_guint(crc32_table, ix)
          val () = crc32 := g0uint_lxor_uint32(lookup, crc_shift)
        in end
  in
    g0uint_lxor_uint32(crc32, uint2uint32(0xFFFFFFFFu))
  end
