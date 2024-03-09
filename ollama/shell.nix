# go generate ./...
# go build -ldflags "-s -w -linkmode external -extldflags -static"
with import <nixpkgs> {}; {
  devEnv = stdenv.mkDerivation {
    name = "Ollama Build Deps";
    buildInputs = [stdenv cmake go glibc.static];
    # cudaPackages.cudatoolkit cudaPackages.cuda_nvcc cudaPackages.libcublas cudaPackages.cuda_cudart
    CFLAGS = "-I${pkgs.glibc.dev}/include";
    LDFLAGS = "-L${pkgs.glibc}/lib";
  };
}
