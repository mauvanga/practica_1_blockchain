//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;
contract FabricaContract {

  uint idDigits = 16;
  uint idModulus = 10^idDigits;

    struct Producto {
        uint identificacion;
        string name;
}

  Producto[] public productos;

  function _crearProducto(string memory _nombre, uint _id) private {

       productos.push(Producto(_id, _nombre));
       emit NuevoProducto(productos.length, _nombre, _id);

    }

  function _generarIdAleatorio(string memory _str) private view returns (uint) {
      
      uint rand = uint(keccak256(abi.encodePacked(_str)))  % idModulus;
      return rand;

    }

    function crearProductoAleatorio(string memory _nombre) public {

      uint randId = _generarIdAleatorio(_nombre);
       _crearProducto(_nombre,randId);
      Propiedad(randId);

    }

    event NuevoProducto(uint ArrayProductoId, string nombre, uint id);

    mapping (uint => address) public productoAPropietario;

    mapping (address => uint) propietarioProductos;

    function Propiedad(uint _productoId) private {

     productoAPropietario[_productoId] = msg.sender;
     propietarioProductos[msg.sender] += 1;

    }

    

    function getProductosPorPropietario(address  _propietario) view external returns (uint[] memory) {

     uint contador = 0;
     uint longitud = propietarioProductos[_propietario];
     uint[] memory resultado = new uint[](longitud);
     


     for (uint x = 0; x < productos.length; x++){

        uint id_producto = productos[x].identificacion;
       if(productoAPropietario[id_producto] == _propietario){
            resultado[contador] = id_producto;
            contador+=1;
      }

     }

     return resultado;

    }

    

}
