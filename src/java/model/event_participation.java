/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author thanm
 */
public class event_participation {
    private int id;
    private int member_id;
    private int event_id;
    private int event_score;

    public event_participation() {
    }

    public event_participation(int id, int member_id, int event_id, int event_score) {
        this.id = id;
        this.member_id = member_id;
        this.event_id = event_id;
        this.event_score = event_score;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    public int getEvent_score() {
        return event_score;
    }

    public void setEvent_score(int event_score) {
        this.event_score = event_score;
    }
    
}
