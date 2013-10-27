module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def helper_class(field)
  	if 'title_header' == field
  		return 'hilite'
 		else
   		return nil
 		end
 	end	
end
