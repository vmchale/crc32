let prelude =
      http://hackage.haskell.org/package/ats-pkg-3.5.0.0/src/dhall/atspkg-prelude.dhall sha256:33e41e509b6cfd0b075d1a8a5210ddfd1919372f9d972c2da783c6187d2298ba

in    prelude.default
    ⫽ { test =
        [   prelude.bin
          ⫽ { src = "src/crc32.dats"
            , target = "${prelude.atsProject}/crc32-test"
            }
        ]
      , compiler = [ 0, 4, 0 ]
      , version = [ 0, 3, 13 ]
      , atsLib = False
      }
