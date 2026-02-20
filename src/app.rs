pub struct MyApp {}

impl MyApp {
    pub fn new(cc: &eframe::CreationContext<'_>) -> Self {
        Self {}
    }
}

impl eframe::App for MyApp {
    fn update(&mut self, ctx: &egui::Context, frame: &mut eframe::Frame) {
        egui::CentralPanel::default().show(ctx, |ui| {
            let time = ctx.input(|i| i.time);

            ui.heading(format!("Hello {:#?}!", time));
        });
    }
}
