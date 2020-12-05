defmodule TwoBalls do
  def get_scene do
    %Scene{
      camera: %Camera{
        background_color: %Colour{r: 0, b: 0, g: 0},
        position: %Vector3{x: 0, y: 0, z: 0},
        # implement later
        direction: %Vector3{x: 0, y: 0, z: 0},
        view_distance: 1,
        view_height: 500,
        view_width: 500
      },
      lights: [
        %AmbientLight{intensity: 0.2},
        %DirectionalLight{direction: %Vector3{x: 0, y: 1, z: 1}, intensity: 0.5}
      ],
      models: [
        %Sphere{
          position: %Vector3{x: 0, y: 0, z: 1000},
          radius: 250,
          colour: %Colour{r: 50, g: 50, b: 133}
        },
        %Sphere{
          position: %Vector3{x: 200, y: 200, z: 1000},
          radius: 50,
          colour: %Colour{r: 255, g: 255, b: 255}
        },
        %Sphere{
          position: %Vector3{x: 250, y: 250, z: 1000},
          radius: 50,
          colour: %Colour{r: 0, g: 255, b: 0}
        },
        %Plane{
          position: %Vector3{x: 0, y: 0, z: 1000},
          angle: %Vector3{x: -0.5, y: 0, z: 0.5},
          colour: %Colour{r: 0, g: 200, b: 200}
        }
      ]
    }
  end
end
