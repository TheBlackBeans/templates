{
  description = "My personal templates";
  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust template, with Naersk and rust-overlay.";
      };
      rust-prologin = {
        path = ./rust-prologin;
        description = "Rust template for prologin problem submission.";
      };
    };
  };
}
