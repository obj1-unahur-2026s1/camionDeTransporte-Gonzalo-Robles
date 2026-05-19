object camion2 {

    const pesoDelCamion = 1000
    var property cargasHabilitadas = []

    method agregarCarga(carga) {cargasHabilitadas.add(carga)}

    method quitarCarga(carga) { cargasHabilitadas.remove(carga)}

    method tara() = pesoDelCamion +cargasHabilitadas.sum({carga => carga.peso()})

    method cargaPar() = cargasHabilitadas.all({carga => carga.peso() % 2 == 0})

    method hayCargaDePeso(pesoBuscado) =cargasHabilitadas.any({carga => carga.peso() == pesoBuscado})

    method primerObjetoPeligroso(nivelBuscado) =
        cargasHabilitadas.find({carga => carga.peligrosidad() == nivelBuscado})

    method cargasPeligrosas(nivel) =cargasHabilitadas.filter({carga => carga.peligrosidad() > nivel})

    method cargasMasPeligrosasQue(carga) = self.cargasPeligrosas(carga.peligrosidad())

    method estaExcedido() = self.tara() > 2500

    method puedeCircular(nivelMaximoPermitido) =
        !self.estaExcedido() &&
        cargasHabilitadas.all({
            carga => carga.peligrosidad() <= nivelMaximoPermitido
        })

    method hayCargaEntre(minimo, maximo) =
        cargasHabilitadas.any({
            carga =>
                carga.peso() >= minimo &&
                carga.peso() <= maximo
        })

    method indicarCargaMasPesada() =
        cargasHabilitadas.max({
            carga => carga.peso()
        })
}

// =========================
// COSAS
// =========================

object knightRider {

    const pesoObjeto = 500
    const nivelPeligrosidad = 10

    method peso() = pesoObjeto
    method peligrosidad() = nivelPeligrosidad
}

object bumblebee {

    const pesoObjeto = 800
    var transformado = true

    method transformar() {transformado = !transformado}
    method peso() = pesoObjeto
    method peligrosidad() {
        if(transformado) {
            return 15
        } else {
            return 30
        }
    }
}

object paqueteDeLadrillos {

    const pesoPorLadrillo = 2
    const nivelPeligrosidad = 2
    var cantidadDeLadrillos = 0

    method prepararPaquete(cantidad) {cantidadDeLadrillos = cantidad}
    method peso() = pesoPorLadrillo * cantidadDeLadrillos
    method peligrosidad() = nivelPeligrosidad
}

object arenaAGranel {

    const nivelPeligrosidad = 1
    var pesoArena = 0
    method cargarArena(cantidad) {pesoArena = cantidad}
    method peso() = pesoArena
    method peligrosidad() = nivelPeligrosidad
}

object bateriaAntiaerea {

    var cargado = false
    method armarBateria() {cargado = true}
    method desarmarBateria() {cargado = false}
    method peso() {
        if(cargado) {
            return 300
        } else {
            return 200
        }
    }

    method peligrosidad() {
        if(cargado) {
            return 100
        } else {
            return 0
        }
    }
}

object contenedor {
    const pesoContenedor = 100
    var property cosasEnElContenedor = []
    method agregarCosa(carga) { cosasEnElContenedor.add(carga)}

    method quitarCosa(carga) { cosasEnElContenedor.remove(carga)}

    method peso() = pesoContenedor + cosasEnElContenedor.sum({cosa => cosa.peso()})

    method peligrosidad() {
        if(cosasEnElContenedor.isEmpty()) {
            return 0
        } else {
            return cosasEnElContenedor.max({cosa => cosa.peligrosidad()}).peligrosidad()
        }
    }
}

object residuosRadiactivos {

    const nivelPeligrosidad = 200
    var pesoResiduos = 0

    method cargarResiduos(cantidad) {pesoResiduos = cantidad}
    method peso() = pesoResiduos
    method peligrosidad() = nivelPeligrosidad
}

object embalajeDeSeguridad {
    var cargaEnvuelta = null
    method embalar(carga) {cargaEnvuelta = carga}
    method peso() = cargaEnvuelta.peso()
    method peligrosidad() = cargaEnvuelta.peligrosidad() / 2
}