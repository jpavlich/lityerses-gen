package com.litierses.Servicios;

import java.util.List;

public abstract class Persistence<T> {
    private Class<T> entityClass;

    public Persistence(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    //protected abstract EntityManager getEntityManager();

    public void create(T entity) {
        //getEntityManager().persist(entity);
    }

    public void save(T entity) {
        //getEntityManager().merge(entity);
    }

    public void remove(T entity) {
        //getEntityManager().remove(getEntityManager().merge(entity));
    }

    //public T find(Object id) {
        //return getEntityManager().find(entityClass, id);

      //  return T;
    //}

    //public List<T> findAll() {
    //public List<T> findAll() {
        //javax.persistence.criteria.CriteriaQuery cq = getEntityManager().getCriteriaBuilder().createQuery();
        //cq.select(cq.from(entityClass));
        //return getEntityManager().createQuery(cq).getResultList();
      //  return null;
    //}

    //public List<T> findRange(int[] range) {
        //javax.persistence.criteria.CriteriaQuery cq = getEntityManager().getCriteriaBuilder().createQuery();
        //cq.select(cq.from(entityClass));
        //javax.persistence.Query q = getEntityManager().createQuery(cq);
        //q.setMaxResults(range[1] - range[0] + 1);
        //q.setFirstResult(range[0]);
        //return q.getResultList();
    //}

    public int count() {
        //javax.persistence.criteria.CriteriaQuery cq = getEntityManager().getCriteriaBuilder().createQuery();
        //javax.persistence.criteria.Root<T> rt = cq.from(entityClass);
        //cq.select(getEntityManager().getCriteriaBuilder().count(rt));
        //javax.persistence.Query q = getEntityManager().createQuery(cq);
        //return ((Long) q.getSingleResult()).intValue();
        return 1;
    }
    public boolean isPersistent(T entity){
        return true;
    }

}
