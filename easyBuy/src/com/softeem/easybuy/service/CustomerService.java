package com.softeem.easybuy.service;

import com.softeem.easybuy.dao.ICustomerDAO;
import com.softeem.easybuy.dao.impl.CustomerDAO;
import com.softeem.esaybuy.dto.Customer;

public class CustomerService {

	private ICustomerDAO dao = new CustomerDAO();
	
	public CustomerService() {
	}
	
	public ServiceModel login(Customer user){
		ServiceModel model = new ServiceModel();
		Object obj = dao.findSingleObj(user);
		if(obj != null){
			Customer c = (Customer)obj;
			if(c.getPassword().equals(user.getPassword())){
				model.setCode(1);
				model.setData(c);
				model.setMessage("µÇÂ¼³É¹¦");
			}else{
				model.setCode(0);
				model.setMessage("ÃÜÂë´íÎó");
			}
		}else{
			model.setCode(-1);
			model.setMessage("ÕËºÅ²»´æÔÚ");
		}
		return model;
	}
	
	public ServiceModel register(Customer user){
		ServiceModel model = new ServiceModel();
		Object obj = dao.findSingleObj(user);
		if(obj == null){
			if(dao.save(user)){
				model.setCode(1);//ok
				model.setMessage("×¢²á³É¹¦");
			}else{
				model.setCode(0);//Òì³£
				model.setMessage("×¢²áÊ§°Ü");
			}
		}else{
			model.setCode(-1);//ÕËºÅÒÑ×¢²á
			model.setMessage("ÕËºÅÒÑ±»×¢²á");
		}
		return model;
	}
}
