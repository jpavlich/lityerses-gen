/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ws;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author SERVER
 */
@Entity
@Table(name = "dieta")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Dieta.findAll", query = "SELECT d FROM Dieta d"),
    @NamedQuery(name = "Dieta.findById", query = "SELECT d FROM Dieta d WHERE d.id = :id"),
    @NamedQuery(name = "Dieta.findByDesayuno", query = "SELECT d FROM Dieta d WHERE d.desayuno = :desayuno"),
    @NamedQuery(name = "Dieta.findByAlmuerzo", query = "SELECT d FROM Dieta d WHERE d.almuerzo = :almuerzo"),
    @NamedQuery(name = "Dieta.findByCena", query = "SELECT d FROM Dieta d WHERE d.cena = :cena"),
    @NamedQuery(name = "Dieta.findByMerienda", query = "SELECT d FROM Dieta d WHERE d.merienda = :merienda"),
    @NamedQuery(name = "Dieta.findByNombre", query = "SELECT d FROM Dieta d WHERE d.nombre = :nombre")})
public class Dieta implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Size(min = 1, max = 2147483647)
    @Column(name = "id")
    private String id;
    @Size(max = 2147483647)
    @Column(name = "desayuno")
    private String desayuno;
    @Size(max = 2147483647)
    @Column(name = "almuerzo")
    private String almuerzo;
    @Size(max = 2147483647)
    @Column(name = "cena")
    private String cena;
    @Size(max = 2147483647)
    @Column(name = "merienda")
    private String merienda;
    @Size(max = 2147483647)
    @Column(name = "nombre")
    private String nombre;

    public Dieta() {
    }

    public Dieta(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesayuno() {
        return desayuno;
    }

    public void setDesayuno(String desayuno) {
        this.desayuno = desayuno;
    }

    public String getAlmuerzo() {
        return almuerzo;
    }

    public void setAlmuerzo(String almuerzo) {
        this.almuerzo = almuerzo;
    }

    public String getCena() {
        return cena;
    }

    public void setCena(String cena) {
        this.cena = cena;
    }

    public String getMerienda() {
        return merienda;
    }

    public void setMerienda(String merienda) {
        this.merienda = merienda;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Dieta)) {
            return false;
        }
        Dieta other = (Dieta) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ws.Dieta[ id=" + id + " ]";
    }
    
}
