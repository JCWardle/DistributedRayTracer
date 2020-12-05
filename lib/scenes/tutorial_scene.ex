defmodule TutorialScene do
  def get_scene do
    %Scene{
      camera: %Camera{
        background_color: %Colour{r: 0, b: 0, g: 0},
        position: %Vector3{x: 0, y: 0, z: 0},
        # implement later
        direction: %Vector3{x: 0, y: 0, z: 0},
        view_distance: 1,
        view_height: 1,
        view_width: 1
      },
      lights: [
        %AmbientLight{intensity: 1}
        # %DirectionalLight{direction: %Vector3{x: 0, y: 1, z: 1}, intensity: 0.5}
      ],
      models: [
        %Sphere{
          position: %Vector3{x: 0, y: -1, z: 3},
          radius: 1,
          colour: %Colour{r: 255, g: 0, b: 0}
        },
        %Sphere{
          position: %Vector3{x: 2, y: 0, z: 4},
          radius: 1,
          colour: %Colour{r: 0, g: 0, b: 255}
        },
        %Sphere{
          position: %Vector3{x: -2, y: 0, z: 4},
          radius: 1,
          colour: %Colour{r: 0, g: 255, b: 0}
        },
        %Sphere{
          position: %Vector3{x: 0, y: -5001, z: 0},
          radius: 5000,
          colour: %Colour{r: 255, g: 255, b: 0}
        }
      ]
    }
  end
end
