defmodule RayTracer do
  use Application
  require Logger

  def test_scene() do
    TutorialScene.get_scene()
  end

  def find_canvas_point_on_view_port(c_x, c_y, c_w, c_h, v_w, v_h, v_d) do
    Vector3.new(c_x * (v_w / c_w), c_y * (v_w / c_h), v_d)
  end

  def get_ray_direction(%Vector3{} = view_point, camera_position) do
    Vector3.subtract(view_point, camera_position)
  end

  def check(%Plane{} = plane, camera_position, ray_direction) do
    case Plane.check_collision(plane, camera_position, ray_direction) do
      nil ->
        nil

      check ->
        [%{:intersection => check.t, :normal => check.normal, :colour => plane.colour}]
    end
  end

  def check(%Sphere{} = sphere, camera_position, ray_direction) do
    case Sphere.check_collision(sphere, camera_position, ray_direction) do
      {t1, t2} ->
        [
          %{:intersection => t1.t, :colour => sphere.colour, :normal => t1.normal},
          %{:intersection => t2.t, :colour => sphere.colour, :normal => t2.normal}
        ]

      nil ->
        nil
    end
  end

  def find_closest_object(scene, ray_direction) do
    camera = scene.camera

    results =
      Enum.map(scene.models, fn model ->
        check_result = check(model, camera.position, ray_direction)

        if(check_result != nil) do
          Enum.map(check_result, fn check ->
            Map.put(check, :shape, model)
          end)
        else
          nil
        end
      end)
      |> Enum.reject(fn result ->
        # remove items that didn't intersect
        result == nil
      end)
      |> Enum.concat()
      |> Enum.reject(fn result ->
        # remove items behind the camera TODO update with direction
        result.intersection < 1
      end)

    if(Enum.count(results) == 0) do
      nil
    else
      Enum.min_by(results, fn result ->
        result.intersection
      end)
    end
  end

  def scan_frame(scene, {canvas_width, canvas_height}) do
    for canvas_x <- Kernel.trunc(-canvas_width / 2)..Kernel.trunc(canvas_width / 2),
        canvas_y <- Kernel.trunc(-canvas_height / 2)..Kernel.trunc(canvas_height / 2) do
      camera = scene.camera

      view_port_vector =
        find_canvas_point_on_view_port(
          canvas_x,
          canvas_y,
          canvas_width,
          canvas_height,
          camera.view_height,
          camera.view_width,
          camera.view_distance
        )

      ray_direction = get_ray_direction(view_port_vector, camera.position)

      case find_closest_object(scene, ray_direction) do
        nil ->
          Pixel.new(canvas_x, canvas_y, scene.camera.background_color)

        shape_hit ->
          intersection_normal = shape_hit.normal
          intersection_point = Vector3.scale(ray_direction, shape_hit.intersection)
          view = Vector3.scale(ray_direction, -1)

          lighting =
            Lighting.calculate_lighting(
              scene,
              intersection_normal,
              intersection_point,
              view,
              shape_hit.shape
            )

          Pixel.new(canvas_x, canvas_y, Colour.light_color(shape_hit.colour, lighting))
      end
    end
  end

  def start(_type, _args) do
    scene = test_scene()
    width = 600
    height = 600
    frame_pixels = scan_frame(scene, {width, height})

    Output.write_to_file("output.png", frame_pixels, width, height)
  end
end
