object camion {

    const pesoDelCamion = 1000
    var property cargasHabilitadas = []

    method agregarCarga(carga) {
        carga.reaccionarALaCarga()
        cargasHabilitadas.add(carga)
    }

    method quitarCarga(carga) {cargasHabilitadas.remove(carga)}

    method tara() =pesoDelCamion + cargasHabilitadas.sum({carga => carga.peso()})

    method cargaPar() = cargasHabilitadas.all({ carga => carga.peso() % 2 == 0 })

    method hayCargaDePeso(pesoBuscado) =cargasHabilitadas.any({ carga => carga.peso() == pesoBuscado})

    method primerObjetoPeligroso(nivelBuscado) = cargasHabilitadas.find({ carga => carga.peligrosidad() == nivelBuscado})

    method cargasPeligrosas(nivel) = cargasHabilitadas.filter({ carga => carga.peligrosidad() > nivel})

    method cargasMasPeligrosasQue(carga) = self.cargasPeligrosas(carga.peligrosidad())
    
    method estaExcedido() = self.tara() > 2500

    method puedeCircular(nivelMaximoPermitido) =
        !self.estaExcedido() && cargasHabilitadas.all({carga => carga.peligrosidad() <= nivelMaximoPermitido})

    method hayCargaEntre(minimo, maximo) =cargasHabilitadas.any({carga => carga.peso() >= minimo &&carga.peso() <= maximo})

    method indicarCargaMasPesada() =cargasHabilitadas.max({carga => carga.peso()})

    method totalBultos() = cargasHabilitadas.sum({carga => carga.bulto()})
// 1) Obtener una lista con los pesos de todas  las cargas del camión.

method pesosDeLasCargas() = cargasHabilitadas.map({ carga => carga.peso()})
// 2) Obtener los niveles de peligrosidad de todas las cargas.

method nivelesDePeligrosidad() = cargasHabilitadas.map({ carga => carga.peligrosidad() })
// Obtener los bultos de cada carga.

method bultosPorCarga() = cargasHabilitadas.map({ carga => carga.bulto() })

//Obtener cuánto pesaría cada carga después de duplicar su peso.

method pesosDuplicados() = cargasHabilitadas.map({ carga => carga.peso() * 2})

// Obtener los pesos de las cargas peligrosas (más de 50 de peligrosidad).

method pesosDeCargasPeligrosas() = 
    cargasHabilitadas.filter({carga => carga.peligrosidad() > 50}).map({carga => carga.peso()})
}

// =========================
// COSAS
// =========================

object knightRider {

    const pesoObjeto = 500
    const nivelPeligrosidad = 10
    const cantidadBulto = 1

    method peso() = pesoObjeto 
    method peligrosidad() = nivelPeligrosidad
    method bulto() = cantidadBulto
    method reaccionarALaCarga() {}
}

object bumblebee {

    const pesoObjeto = 800
    const cantidadPorBulto = 2
    var transformado = true

    method transformar() { transformado = !transformado }
    method peso() = pesoObjeto
    method peligrosidad() {
        if(transformado) { return 15} 
        else { return 30}
    }
    method bulto() = cantidadPorBulto
    method reaccionarALaCarga() { transformado = false }
}

object paqueteDeLadrillos {

    const pesoPorLadrillo = 2
    const nivelPeligrosidad = 2
    var cantidadDeLadrillos = 0

    method prepararPaquete(cantidad) { cantidadDeLadrillos = cantidad }

    method peso() = pesoPorLadrillo * cantidadDeLadrillos

    method peligrosidad() = nivelPeligrosidad

    method bultos() {
        if(cantidadDeLadrillos <= 100) { return 1 }
        if(cantidadDeLadrillos <= 300) {return 2}
        return 3
    }

    method bulto() = self.bultos()

    method reaccionarALaCarga() { cantidadDeLadrillos += 12}
}

object arenaAGranel {

    const nivelPeligrosidad = 1
    const cantidadPorBulto = 1
    var pesoArena = 0

    method cargarArena(cantidad) { pesoArena = cantidad}
    method peso() = pesoArena
    method peligrosidad() = nivelPeligrosidad
    method bulto() = cantidadPorBulto

    method reaccionarALaCarga() { pesoArena -= 10}
}

object bateriaAntiaerea {
    var cargado = false
    method armarBateria() {cargado = true }
    method desarmarBateria() {cargado = false}
    method peso() {
        if(cargado) {return 300} 
        else {return 200}
    }

    method peligrosidad() {
        if(cargado) { return 100 } 
        else { return 0 }
    }

    method bulto() {
        if(cargado) { return 2} 
        else { return 1}
    }

    method reaccionarALaCarga() {cargado = true}
}

object contenedor {
    const pesoContenedor = 100
    var property cosasEnElContenedor = []
    
    method agregarCosa(carga) {cosasEnElContenedor.add(carga)}
    method quitarCosa(carga) {cosasEnElContenedor.remove(carga)}
    method peso() = pesoContenedor + cosasEnElContenedor.sum({cosa => cosa.peso()})

    method peligrosidad() {
        if(cosasEnElContenedor.isEmpty()) { return 0 } 
        else { return cosasEnElContenedor.max({cosa => cosa.peligrosidad()}).peligrosidad()}
    }

    method bulto() = 1 + cosasEnElContenedor.sum({cosa => cosa.bulto()})
    method reaccionarALaCarga() { cosasEnElContenedor.forEach({cosa => cosa.reaccionarALaCarga()})}
}

object residuosRadiactivos {
    const nivelPeligrosidad = 200
    const cantidPorBulto = 1
    var pesoResiduos = 0

    method cargarResiduos(cantidad) {pesoResiduos = cantidad}
    method peso() = pesoResiduos
    method peligrosidad() = nivelPeligrosidad
    method bulto() = cantidPorBulto
    method reaccionarALaCarga() { pesoResiduos += 15}
}

object embalajeDeSeguridad {
    var cargaEnvuelta = null

    method embalar(carga) {cargaEnvuelta = carga}
    method peso() = cargaEnvuelta.peso()
    method peligrosidad() = cargaEnvuelta.peligrosidad() / 2
    method bulto() = 2
    method reaccionarALaCarga() {}
}


