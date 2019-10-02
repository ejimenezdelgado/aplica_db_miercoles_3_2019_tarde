Create view view_empleado_informacion as

SELECT 
  empleado.nombre, 
  empleado.apellido, 
  empleado.fecha_nacimiento, 
  empleado.precio_hora, 
  empleado.id_departamento, 
  puesto.nombre as puesto, 
  puesto.admin,  
  departamento.nombre as departamento
FROM 
  public.departamento, 
  public.empleado, 
  public.puesto
WHERE 
  departamento.id = empleado.id_departamento AND
  puesto.id = empleado.id_puesto;


