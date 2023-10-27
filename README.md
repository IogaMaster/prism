<h1 align="center">prism</h1>
<h2 align="center">home-manager module to recolor wallpapers, built with <a href="https://github.com/ozwaldorf/lutgen-rs">lutgen</a></h2>


<h1 align="center">
<a href='#'><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/></a>
  <br>
  <br>
  <div>
    <a href="https://github.com/Iogamaster/prism/issues">
        <img src="https://img.shields.io/github/issues/Iogamaster/prism?color=fab387&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/Iogamaster/prism/stargazers">
        <img src="https://img.shields.io/github/stars/Iogamaster/prism?color=ca9ee6&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/Iogamaster/prism">
        <img src="https://img.shields.io/github/repo-size/Iogamaster/prism?color=ea999c&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/Iogamaster/prism/blob/main/.github/LICENCE">
        <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=ca9ee6&colorA=313244&colorB=cba6f7"/>
    </a>
    <br>
    </div>
        <img href="https://builtwithnix.org" src="https://builtwithnix.org/badge.svg"/>
   </h1>
   <br>


<details>
<summary>🖼️ Gallery</summary>

| Original  | Oxocarbon  |  Gruvbox Dark |   
|---|---|---|
| ![space324dhsj](https://github.com/IogaMaster/prism/assets/67164465/293620a2-ee45-4d8f-b899-020fb67c2b6f)  |  ![image](https://github.com/IogaMaster/prism/assets/67164465/ea04e94b-c063-4d29-8e61-1743b92ecf14) |  ![image](https://github.com/IogaMaster/prism/assets/67164465/2997db23-ba38-490f-a408-392783edbb2c) |   
| ![rose_pine_shape](https://github.com/IogaMaster/prism/assets/67164465/b4592096-7729-489c-97eb-dc91b2df8dde)  | ![image](https://github.com/IogaMaster/prism/assets/67164465/019d149f-54f4-441e-999e-98c426ae1ca8) | ![image](https://github.com/IogaMaster/prism/assets/67164465/fbb3bbc2-e2fa-4f77-88b7-33974594f019)
| ![spiral](https://github.com/IogaMaster/prism/assets/67164465/2d72c231-2bff-4f35-8d2a-320c210e120e) | ![image](https://github.com/IogaMaster/prism/assets/67164465/c2ad3db8-3cae-4a8d-bd96-a2eec92a0e36)| ![image](https://github.com/IogaMaster/prism/assets/67164465/ddaab71c-d30f-4ddb-8998-31ef661d163e) |
 


</details>

## Usage

> \[!WARNING\]\
> Images that are already in the colorscheme specified are changed to be more muted.
> 
> I am addressing this [here](https://github.com/ozwaldorf/lutgen-rs/issues/12)

> \[!NOTE\]\
> If you add or remove an image from the wallpapers path, ALL wallpapers will be rebuilt.
>
> Depending on the number and resolution of wallpapers, switching to a new generation can take a long time.


Include in your flake
```nix
inputs.prism.url = "github:IogaMaster/prism";
```

Include the `prism.homeModules.prism` module the way you like.

Here are all the colorschemes:
https://github.com/ozwaldorf/lutgen-rs/blob/main/palettes/palettes.json

To use `Gruvbox Dark` you need to specify `colorscheme = "gruvbox-dark";`

Using the module:
```nix
prism = {
  enabled = true;
  wallpapers = ./wallpapers; # Path to the wallpapers directory in your config. (IMAGES ONLY)
  outPath = ".config/wallpapers"; # Where in your home directory to output to.

  # This is can be a string, or a list of strings.
  colorscheme = "catppuccin-mocha"; 

  # Colors are formatted the same as a base16 scheme
  # colorscheme = [ "FFFFFF" "FAFAFA" ... ]; 
};
```

If you like prism, consider checking out [nix-colors](https://github.com/Misterio77/nix-colors).
