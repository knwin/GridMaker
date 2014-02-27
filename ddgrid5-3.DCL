/*Ddgrid5-2.dcl for ddgrid5-2.lsp*/
gd_box1 : dialog {
	label = "GRID MAKER Ver 5.2 (Developed by Kyaw Naing Win)";
	  : row {
	    : column {
	    	: boxed_column {
	    	label = "Major Grid";
	    	  : toggle {
                  label = "&Creat Grid Layer";
                  key = "grid_layer";
		  mnemonic = "C";
		  fixed_width = true;
      		  }
                  : row {
		   : boxed_column {  
                   label = "Grid interval"; 
		    : edit_box {
		    label = "along  X  Axis";
		    key = "gd_spcH";
		    edit_width = 4;
		    }
                    : edit_box {
                    label = "along Y Axis";
                    key = "gd_spcV";
                    edit_width = 4;
                    }
		   }
		   
                  }
                  : boxed_row {
                    : row {
		 	 : button {
		   	 label = "Grid &Color >";
		   	 key = "mjgd_color";
		   	 mnemonic = "C";
		   	 height = 1.25;
		    	 width = 5;
		    	 fixed_width = true;
		    	 fixed_height = true;
		   	 }
		   	 : spacer {width = 1;}
		  	 /*: column {*/
		  	   : text {
		  	   label = "Current";
			   key = "mjgdcolor_text";
			   width = 4;
			   fixed_width=true;
			   }
                    	   : image {
		   	   key = "mjgdcolor_image";
		    	   height = 1.25;
		   	   width = 6;
		    	   fixed_width = true;
		    	   fixed_height = true;
		  	   }
		  	 }  
		    /*}*/
		  }  
		}
		: boxed_column {
		  label = "Minor Grid";
		     : column {
			 : toggle {
                	 label = "Draw Minor &Grid ";
                 	 key = "minorgd";
		 	 mnemonic = "G";
		 	 fixed_width = true;
			 }
                         : boxed_column {
                           label = "Number of minor grids betwen two major grids";
			   : edit_box {
			   label = "along  X  Axis ";
			   key = "mngd_Hno";
			   edit_width = 4;
			   }
			   : edit_box {
			   label = "along  Y  Axis ";
			   key = "mngd_Vno";
			   edit_width = 4;
			   }
	 		 }
	             }
	             : boxed_row {
		       : row {
		  	 : button {
		    	 label = "Grid Color >";
		    	 key = "mngd_color";
		    	 mnemonic = "I";
		    	 height = 1.25;
		    	 width = 5;
		    	 fixed_width = true;
		    	 fixed_height = true;
		  	 }
		  	 : spacer { width=1;}
		  	 /*: column {*/
		  	   : text {
			   label = "Grey(defult)";
			   key = "mngdcolor_text";
			   width = 5;
			   }
			   : image {
		    	   key = "mngdcolor_image";
		    	   height = 1.25;
		    	   width = 6;
		    	   fixed_width = true;
		    	   fixed_height = true;
			   }
			 }  
		       /*}*/
		     }  
		 }
	       	}
	  	: boxed_column {
		  label = "Text";
		  : toggle {
                  label = "&Label Grid";
                  key = "annogrd";
		  mnemonic = "L";
		  fixed_width = true;
      		  }
      		  : toggle {
                  label = "Label &outside boundary";
                  key = "txtout";
		  mnemonic = "O";
		  fixed_width = true;
      		  }
      		  : toggle {
                  label = "Only at left and lower boundary";
                  key = "below_left";
		  mnemonic = "O";
		  fixed_width = true;
      		  }
		  : boxed_column {

			 : edit_box {
			 label = "Text &size";
			 key = "gd_txt";
			 edit_width = 4;
			 }
			 :edit_box {
			 label = "Text &Indent";
			 key = "gd_txind";
			 edit_width = 4;
			 }
			 :edit_box {
			 label = "Decimal precision";
			 key = "l_uprec";
			 edit_width = 4;
			 }
			 :edit_box {
			 label = "Prefix along  X  Axis";
			 key = "prefix_e";
			 edit_width = 4;
			 }
			 :edit_box {
			 label = "Prefix along  Y  Axis";
			 key = "prefix_n";
			 edit_width = 4;
			 }
			 :edit_box {
			 label = "Suffix along  X  Axis";
			 key = "suffix_e";
			 edit_width = 4;
			 }
			 :edit_box {
			 label = "Suffix along  Y  Axis";
			 key = "suffix_n";
			 edit_width = 4;
			 }
		     }
		     : boxed_row {
		  	 : button {
		    	 label = "&Text Color >";
		   	 key = "mjgdtext_color";
		    	 mnemonic = "T";
		    	 height = 1.25;
		    	 width = 5;
		    	 fixed_width = true;
		    	 fixed_height = true;
		  	 }
		  	 : row {
			   : text {
			   label = "White(defult)";
			   key = "mjgdtext_colortext";
			   width = 5;
			   }
		  	   : image {
		    	   key = "textcolor_image";
		   	   height =1.25 ;
		    	   width = 6;
		    	   fixed_width = true;
		    	   fixed_height = true;
		  	   }
		  	 }
		     }
		     : spacer {width = 1;}
		     : boxed_column {
	             label = "Scale factor";
		       : edit_box {
		       label = "along  X  Axis";
		       key = "h_scale";
		       edit_width = 4;
		       }
		       : edit_box {
		       label = "along  Y  Axis";
		       key = "v_scale";
		       edit_width = 4;
		       }
	             }
	             : spacer {width = 1;}
	        }
	  	  
	}	
	  : row {
	    : spacer {width = 1;}
	    : button {
	    label = "OK Proceed";
	    key = "accept";
	    width = 15;	  
	    fixed_width = true;
	    }
	    : button {
	    label = "Cancel";
	    is_cancel = true;
	    key = "cancel";
	    width = 8;	  
	    fixed_width = true;
	    }
	    : spacer { width = 1;}
	 }	
  
}