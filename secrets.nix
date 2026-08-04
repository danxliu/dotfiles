let
  argy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDe91YSDZz72g92PECbaz0Qy9Gom1o8Bbt1kqhuqO7Zt";
  daniel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGNi7bXmqv79tcy9wOesO6IvwmvdoT+vZVNoXJ0BanNu";
in
{
  "secrets/hermes-env.age".publicKeys = [ argy daniel ];
}
