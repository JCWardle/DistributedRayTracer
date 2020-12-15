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
        %AmbientLight{intensity: 0.2},
        %DirectionalLight{direction: %Vector3{x: 1, y: 4, z: 4}, intensity: 0.2},
        %PointLight{position: %Vector3{x: 2, y: 1, z: 0}, intensity: 0.6}
      ],
      models: [
        %Sphere{
          position: %Vector3{x: 0, y: -1, z: 3},
          radius: 1,
          colour: %Colour{r: 255, g: 0, b: 0},
          material: %DefaultMaterial{specular: 500, reflective: 0.2}
        },
        %Sphere{
          position: %Vector3{x: 2, y: 0, z: 4},
          radius: 1,
          colour: %Colour{r: 0, g: 0, b: 255},
          material: %DefaultMaterial{specular: 500, reflective: 0.3}
        },
        %Sphere{
          position: %Vector3{x: -2, y: 0, z: 4},
          radius: 1,
          colour: %Colour{r: 0, g: 255, b: 0},
          material: %DefaultMaterial{specular: 10, reflective: 0.4}
        },
        %Sphere{
          position: %Vector3{x: 0, y: -5001, z: 0},
          radius: 5000,
          colour: %Colour{r: 255, g: 255, b: 0},
          material: %DefaultMaterial{specular: 1000, reflective: 0.5}
        }
      ]
    }
  end
end
