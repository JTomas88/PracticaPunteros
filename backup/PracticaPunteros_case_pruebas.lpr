program PracticaPunteros_case_pruebas;


type
  TListaNumeros=^TNodo;
  TNodo=record
    numero:integer;
    siguiente:TListaNumeros;
  end;

 var
   numerosAImprimir, numeroDelUsuario:integer;
   listado , listadoNuevo: TListaNumeros;
   opcionUsuario, opcion2Usuario: char;
   BorrarPrimerRepetido, BorrarUltimoRepetido, ultimoEncontrado, todasRepeticiones1,PrimeroUltimo1:boolean;
   opcion3Usuario:string;


{Función crearLista: que reciba como argumento un entero con el largo de la
lista a crear, y retorne como resultado una lista encadenada de enteros del largo indicado (de
tipo ListaNumeros). Cada nodo debe contener un entero al azar entre 0 y 9. Si el largo
pasado como argumento es menor o igual que cero, se retorna una lista vacía (puntero NIL)}
function crearLista (NumerosAMostrar:integer) : TListaNumeros;
var apuntar, primerNodo, nodos: TListaNumeros;
    it: integer;

begin

  randomize;

  if (numerosAMostrar <> 0) then begin
      NEW(primerNodo);
      primerNodo^.numero:=random(10);
      primerNodo^.siguiente:=NIL;
      apuntar:=primerNodo;

      if (numerosAMostrar <= 0) then begin
         nodos:=NIL;
         end else begin
      for it:=2 to numerosAmostrar do begin
          NEW(nodos);
          nodos^.numero:=random(10);
          nodos^.siguiente:=NIL;
          apuntar^.siguiente:=nodos;
          apuntar:=nodos;
      end;
      end;

  end;

  apuntar:=primerNodo;
  result:=apuntar;

end;


{Procedimiento imprimirLista: que reciba como argumento por referencia
constante (const) la lista de tipo ListaNumeros e imprima en la salida estándar todos
los valores que contiene, separados por espacio, en el orden en que aparecen en la lista}
procedure imprimirLista (const lista:TListaNumeros);
var listado: TListaNumeros;
begin

  listado:=lista;
  if numerosAimprimir <>0 then begin
  while listado<>NIL do begin
    write (listado^.numero,'  ');
    listado:=listado^.siguiente;
  end;

end;

end;



{Función contarOcurrencias: que reciba dos argumentos: un
número entero y una lista de tipo ListaNumeros por referencia constante. La función
retornará un entero indicando la cantidad de veces que el número pasado como argumento
aparece en la lista. Si no aparece ninguna vez, obviamente se retornará cero (0)}
function contarOcurrencias (const numeroUsuario:integer; const lista:TListaNumeros):integer;
var repeticiones, it: integer;
    apuntador: TListaNumeros;
begin
  repeticiones:=0;


  apuntador:=lista;
  for it:=1 to numerosAImprimir do begin
    if apuntador^.numero<>numeroUsuario then begin
      result:=repeticiones;
    apuntador:=apuntador^.siguiente;
    end else if apuntador^.numero=numeroUsuario then begin
      repeticiones:=repeticiones+1;
      apuntador:=apuntador^.siguiente;
    end;
  end;

  result:=repeticiones;


  writeln ('El numero ',numeroUsuario,' se repite ',repeticiones,' veces');



end;

{Procedimiento borrarLista: que reciba por referencia variable (var) un
argumento de tipo ListaNumeros y elimine todos los nodos que contiene. El argumento
debe quedar con el valor NIL al finalizar la operación.}
procedure borrarLista (var lista:TListaNumeros);
var apuntador, anterior:TListaNumeros;
begin

  if lista^.siguiente<>NIL then begin
      dispose(lista);
      lista:=NIL;
  end else begin
      apuntador:=lista;
      anterior:=NIL;
      while apuntador^.siguiente<>NIL do begin
        anterior:=apuntador;
        apuntador:=apuntador^.siguiente;
      end;

      anterior^.siguiente:=NIL;
      dispose(apuntador);
  end;

  lista:=NIL;

end;

{reciba dos argumentos: un entero y, por referencia variable, una lista de tipo ListaNumeros. La
función deberá recorrer la lista y borrar la primera aparición del número indicado. Si se
encuentra el número y se hace una eliminación se retornará TRUE. Si el número indicado no
estaba en la lista se retornará FALSE. Si el nodo eliminado era el único nodo de la lista ésta
quedará vacía. Si la lista ya estaba vacía no se hará nada y se retornará FALSE.}
function borrarPrimeraOcurrencia (numeroUsuario:integer; var lista: TListaNumeros): boolean;
var apuntador, anterior: TListaNumeros;
    it: integer;
begin

  if numerosAImprimir=0 then begin
     apuntador:=NIL;
     writeln ('No hay nodos para borrar en la lista');
  end else begin
    apuntador:=lista;
    if apuntador=NIL then begin {si la lista está vacía...}
      result:=false;
      writeln ('La lista está vacia');
    end else if (apuntador^.siguiente=NIL) and (apuntador^.numero=numeroUsuario)  then begin {si tiene un sólo elemento lo elimino y dejo la lista vacia}
        dispose(apuntador);
        apuntador:=NIL;
        result:=true;
        writeln ('Nodo coincide y borrado');
        exit;
      end else if (apuntador^.siguiente=NIL) and (apuntador^.numero<>numeroUsuario) then begin
        result:=false;
        writeln ('El numero indicado no esta en la lista');
        exit;
      end;
    end;

  {Si la lista tiene más d 2 nodos:}
   apuntador:=lista;
   anterior:=NIL;
  while apuntador<>NIL do begin
   if apuntador^.numero<>numeroUsuario then begin
     anterior:=apuntador;
     apuntador:=apuntador^.siguiente;
     result:=false;
   end else if apuntador=lista then begin {>> estoy al principio de la lista}
    lista:=lista^.siguiente;
    dispose(apuntador);
    result:=true;
    exit; //25/10
  end else if apuntador^.siguiente=NIL then begin {>> estoy al final de la lista}
     anterior^.siguiente:=NIL;
     dispose (apuntador);
  end else if apuntador<>NIL then begin {>> estoy en medio de la lista}
    anterior^.siguiente:=apuntador^.siguiente;
    dispose(apuntador);
    result:=true;
    exit; //25/10

  end;
 end;


end;

{Funcion leerListaAlReves: esta función recibe la lista y devuelve una lista}
function LeerListaAlReves( listaModificar: TListaNumeros): TListaNumeros;

var
  listadoNuevo, actual, nuevoNodo: TListaNumeros;

begin

  {crea una nueva lista de números y la inicializa como vacía}
  {la lista que recibe la asigna a la variable de tipo lista "actual"}
  listadoNuevo := nil;
  actual := listaModificar;

  {mientras la lista "actual" no esté vacía,
  va creando en cada vuelta un nodo que contiene el valor numérico del nodo por
  el que acaba de pasar y un nuevo nodo que contiene una lista vacía}
  while actual <> nil do begin
    New(nuevoNodo);
    nuevoNodo^.numero := actual^.numero;
    nuevoNodo^.siguiente := listadoNuevo;

    {Pasa los valores que tenga nuevoNodo a listadoNuevo}
    listadoNuevo := nuevoNodo;

    {Avanza al siguiente nodo en la lista original}
    actual := actual^.siguiente;

  end;{>>finaliza el recorrido por el while}

  {Devuelve la nueva lista enlazada}
  result := listadoNuevo;

end;


{Función borrarUltimaOcurrencia que reciba dos argumentos:
un entero y, por referencia variable, una lista de tipo ListaNumeros. La función deberá
recorrer la lista y borrar la última aparición del número indicado. El resto del
comportamiento es exactamente igual a borrarPrimeraOcurrencia}
function borrarUltimaOcurrencia (numeroUsuario:integer; var lista: TListaNumeros): boolean;

var
  apuntador, anterior, listaReves: TListaNumeros;
begin

  {llamamos a la función que nos permitirá invertir la lista}
  listaReves:=LeerListaAlReves(lista);

  if numerosAImprimir=0 then begin
     apuntador:=NIL;
     writeln ('No hay nodos para borrar en la lista');
  end else begin
    apuntador:=listaReves;
    if apuntador=NIL then begin {si la lista está vacía...}
      result:=false;
      writeln ('La lista está vacia');
    end else if (apuntador^.siguiente=NIL) and (apuntador^.numero=numeroUsuario)  then begin {si tiene un sólo elemento lo elimino y dejo la lista vacia}
        dispose(apuntador);
        apuntador:=NIL;
        result:=true;
        writeln ('Nodo coincide y borrado. Deberas crear una lista nueva!');

        exit;
      end else if (apuntador^.siguiente=NIL) and (apuntador^.numero<>numeroUsuario) then begin
        result:=false;
        writeln ('El numero indicado no esta en la lista');
        exit;
      end;
    end;

  {Si la lista tiene más d 2 nodos:}
   apuntador:=listaReves;
   anterior:=NIL;
  while apuntador<>NIL do begin
   if apuntador^.numero<>numeroUsuario then begin
     anterior:=apuntador;
     apuntador:=apuntador^.siguiente;
     result:=false;
   end else begin
     break;
   end;
  end;


  if apuntador=listaReves then begin {>> estoy al principio de la lista}
    listaReves:=listaReves^.siguiente;
    dispose(apuntador);
  {end else if apuntador^.siguiente=NIL then begin {>> estoy al final de la lista}
     anterior^.siguiente:=NIL;
     dispose (apuntador); }
  end else if apuntador<>NIL then begin {>> estoy en medio de la lista}
    anterior^.siguiente:=apuntador^.siguiente;
    dispose(apuntador);
  end;

  {llamamos a la función LeerListaAlReves y el valor que nos devuelve se lo
  asignamos a listado, que es global.}
  listado:=LeerListaAlReves(listaReves);
end;





{Procedimiento borrarOcurrencias, el cual recibirá 4 argumentos:
1. Un entero que se utilizará para buscar y eliminar de la lista.
2. Una lista de tipo ListaNumeros por referencia variable.
3. Un booleano que indicará si se deben eliminar solo las repeticiones del número o
bien si se deben eliminar todas las apariciones del mismo.
4. Un booleano que indicará si debe permanecer en la lista la primera ocurrencia del
número, o bien, la última.
El comportamiento de esta operación es el siguiente: si se indica que se deben eliminar todas
las apariciones del número pasado como argumento, entonces se borrarán todos los nodos en
que dicho número aparece, sin dejar ninguno. En caso contrario, se tomará en cuenta el
argumento booleano que indica si se ha de dejar la primera ocurrencia o la última. En el
primer caso se eliminarán todos los nodos que contienen el número menos el primero en que
aparece. En el segundo caso se eliminarán todos los nodos que contienen el número menos
el último en que aparece.}
procedure borrarOcurrencias (numeroUsuario:integer; todasRepeticiones, primerOultimo: boolean; var lista: TListaNumeros);
var
  apuntador, siguiente, anterior: TListaNumeros;
  validacionOcurrencia, validacionPrimerUltimo ,repetido:boolean;
begin

  todasRepeticiones:=false;
  primerOultimo:=false;
  repetido:= false;

  {pedimos al usuario el numero que quiere encontrar:}
  write ('Numero a encontrar>>> ');
  readln (numeroUsuario);
  writeln;

  writeln ('Deseas borrar todas las repeticiones? Si[S] // No[N] >> ');
  readln (opcion2Usuario);
  writeln;

      if (opcion2Usuario='S') or (opcion2Usuario='s') then begin
        if numerosAImprimir=0 then begin
          apuntador:=NIL;
          writeln ('No hay nodos para borrar en la lista');
        end else begin
          apuntador:=lista;
        end;
        if apuntador=NIL then begin {si la lista está vacía...}
          writeln ('La lista está vacia');
        end else if (apuntador^.siguiente=NIL) and (apuntador^.numero=numeroUsuario)  then begin {si tiene un sólo elemento lo elimino y dejo la lista vacia}
          dispose(apuntador);
          apuntador:=NIL;
          writeln ('Nodo coincide y borrado');
          exit;
        end else if (apuntador^.siguiente=NIL) and (apuntador^.numero<>numeroUsuario) then begin
          writeln ('El numero indicado no esta en la lista');
          exit;
        end;
        todasRepeticiones:=true;

      while validacionOcurrencia do begin
       validacionOcurrencia:=borrarPrimeraOcurrencia (numeroUsuario, lista);
      end;


    end else if (opcion2Usuario='N') or (opcion2Usuario='n') then begin
      writeln ('Indica si quieres conservar'+#13#10+
              ' -> El primer numero que se repita [PRIMER]' +#13#10+
              ' -> Ultimo numero que se repita [ULTIMO] >>');
      readln (opcion3Usuario);
      primerOultimo:=TRUE;
      if (opcion3Usuario='PRIMER') or (opcion3Usuario='primer') then begin
        apuntador:=lista;
         anterior:=NIL;
        while apuntador<>NIL do begin
          if (apuntador^.numero=numeroUsuario) then begin
            apuntador:=apuntador^.siguiente;
            siguiente:=apuntador;
            break;
          end;
         apuntador:=apuntador^.siguiente;
        end;

         siguiente:=apuntador;
         anterior:=NIL;
        while siguiente<>NIL do begin
          if (siguiente^.numero=numeroUsuario) then begin
                if siguiente^.numero<>numeroUsuario then begin
                  anterior:=siguiente;
                  siguiente:=siguiente^.siguiente;
                end else if siguiente=lista then begin {>> estoy al principio de la lista}
                 lista:=lista^.siguiente;
                 dispose(siguiente);
               end else if siguiente^.siguiente=NIL then begin {>> estoy al final de la lista}
                  anterior^.siguiente:=NIL;
                  dispose (siguiente);
               end else if siguiente<>NIL then begin {>> estoy en medio de la lista}
                 anterior^.siguiente:=siguiente^.siguiente;
                 dispose(siguiente);

               end;
          end;
          siguiente:=siguiente^.siguiente;
        end;

      end else if (opcion3Usuario='ULTIMO') or (opcion3Usuario='ultimo') then begin
      //
      end;

    end;


  end;






{************ PROGRAMA PRINCIPAL ************}



begin

listado:=NIL;
writeln ('***** EJERCICIO PUNTEROS *****');
writeln;


repeat
  writeln ('Escoge la cantidad de numeros que tendra la lista (debe ser mayor que 0): ');
  readln(numerosAImprimir);
until numerosAImprimir>0;




REPEAT

  if listado=NIL then begin
    {Se genera la lista de numeros aleatorios}
    listado:=crearLista(numerosAImprimir);
    writeln;
    writeln ('Los numeros aleatorios son: ');
    imprimirLista(listado);
  end else begin
      imprimirLista(listado);
  end;

  writeln;
  writeln;
  writeln ('------------ MENU PRINCIPAL ------------');
  writeln;
  writeln ('Escoge una de las siguientes opciones: ');
  writeln;
  writeln ('1) Contar el numero de veces que se repite un numero en la lista');
  writeln;
  writeln ('2) Borrar el primer numero repetido [borrarPrimeraOcurrencia]');
  writeln (    'NOTA SI EL NUMERO SE REPITE: SE BORRARA EL PRIMERO ENCONTRADO');
  writeln;
  writeln ('3) Borrar el ultimo numero repetido [borrarUltimaOcurrencia]');
  writeln (    'NOTA: SI EL NUMERO SE REPTE SE BORRARA EL ULTIMO ENCONTRADO');
  writeln;
  writeln ('4) BORRAROCURRENICAS --> PENDIENTE');
  writeln;
  writeln ('5) Borrar toda la lista de numeros');
  writeln;
  writeln ('6) Generar una nueva lista de numeros');
  writeln;
  writeln ('0) Salir del programa');
  writeln;
  readln (opcionUsuario);

  case opcionUsuario of

      '1': begin
        writeln ('--CONTAR EL NUMERO DE VECES QUE SE REPITE UN NUMERO EN LA LISTA--');
        writeln('Indica el numero del 1 al 10 para mostrar cuantas veces se repite: ');
        readln(numeroDelUsuario);
        contarOcurrencias (numeroDelUsuario, listado);
        writeln;
        writeln ('--------------------------------------------------------------');
        readln;
      end;

      '2':begin
        writeln ('--BORRAR EL PRIMER NUMERO REPETIDO--');
          {pedimos al usuario el numero que quiere encontrar:}
          write ('Numero a encontrar>>> ');
          readln (numeroDelUsuario);
          BorrarPrimerRepetido:=borrarPrimeraOcurrencia (numeroDelUsuario, listado);

        if BorrarPrimerRepetido then begin
          writeln;
        end;

        writeln;
        writeln ('--------------------------------------------------------------');
        readln;
      end;

      '3':begin
        writeln ('--BORRAR EL ULTIMO NUMERO REPETIDO--');
        {pedimos al usuario el numero que quiere encontrar:}
        write ('Numero a encontrar>>> ');
        readln (numeroDelUsuario);

        borrarUltimaOcurrencia (numeroDelUsuario, listado);

        writeln;
        writeln ('--------------------------------------------------------------');
        readln;
       end;


      '4':begin
        writeln ('--BORRAR OCURRENCIAS--');

        borrarOcurrencias(numeroDelUsuario, todasRepeticiones1,PrimeroUltimo1, listado);
      end; //case 4


      '5':begin
        writeln ('--BORRAR TODA LA LISTA DE NUMEROS--');
        borrarLista (listado);
        writeln ('La lista se ha borrado');
        writeln;
        writeln ('--------------------------------------------------------------');
       end; //case 5



  end; //case principal

until opcionUsuario='0';







readln;
end.

