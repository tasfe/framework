// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.searchbox.domain.dm;

import com.searchbox.domain.dm.Collection;
import com.searchbox.domain.dm.Field;
import com.searchbox.domain.dm.FieldType;

privileged aspect Field_Roo_JavaBean {
    
    public String Field.getKey() {
        return this.key;
    }
    
    public void Field.setKey(String key) {
        this.key = key;
    }
    
    public String Field.getLabel() {
        return this.label;
    }
    
    public void Field.setLabel(String label) {
        this.label = label;
    }
    
    public FieldType Field.getType() {
        return this.type;
    }
    
    public void Field.setType(FieldType type) {
        this.type = type;
    }
    
    public Collection Field.getCollection() {
        return this.collection;
    }
    
    public void Field.setCollection(Collection collection) {
        this.collection = collection;
    }
    
}
