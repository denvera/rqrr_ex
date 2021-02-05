use image;
use rqrr;
use rustler::{Binary,NifStruct};


#[derive(Debug, NifStruct, Clone)]
#[module = "RqrrEx.Point"]
pub struct Point {
    pub x: i32,
    pub y: i32,
}

#[derive(Debug, NifStruct, Clone)]
#[module = "RqrrEx.Metadata"]
pub struct MetaData {
    /// The version/size of the grid
    pub version: usize,
    /// the error correction leven, between 0 and 3
    pub ecc_level: u16,
    /// The mask that was used, value between 0 and 7
    pub mask: u16,
    pub bounds: Vec<(i32, i32)>,
}

#[rustler::nif]
fn detect_qr_codes(bytes: Binary) -> Result<Vec<Result<(MetaData, String), String>>, String> {
    match image::load_from_memory(bytes.as_slice()) {
        Ok(img) => {
            let img = img.to_luma8();
            // Prepare for detection
            // Ok(rqrr::PreparedImage::prepare(img))
            // Search for grids, without decoding
            let mut img = rqrr::PreparedImage::prepare(img);
            let grids = img.detect_grids();
            // Decode the grid
            let mut results = Vec::new();
            for grid in grids.iter() {
                match grid.decode() {
                    Ok((meta, content)) => {
                        results.push(
                            Ok(
                                (
                                MetaData {
                                    version: meta.version.to_size(),
                                    ecc_level: meta.ecc_level,
                                    mask: meta.mask,
                                    bounds: grid.bounds.iter().map(|b| (b.x, b.y)).collect(),
                                },
                                content,
                                )
                            )
                        );
                    }
                    Err(error) => {
                        results.push(Err(error.to_string()));
                    }
                }
            }
            Ok(results)
        }
        Err(error) => Err(error.to_string()),
    }
}

rustler::init!("Elixir.RqrrEx", [detect_qr_codes]);
