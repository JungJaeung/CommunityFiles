package board;

import java.sql.Timestamp;

public class BoardList {
	private String id;
	private String name;
	private String title;
	private String list;
	private Timestamp writeDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getList() {
		return list;
	}
	public void setList(String list) {
		this.list = list;
	}
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	
	@Override
	public String toString() {
		return "BoardList [id=" + id + ", name=" + name + ", title=" + title + ", list=" + list + ", writeDate="
				+ writeDate + "]";
	}

}
