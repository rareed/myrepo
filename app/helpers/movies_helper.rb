module MoviesHelper
	# Checks if a number is odd
	def oddness(count)
		count.odd? ? "odd" :  "even"
	end
end
module MoviesHelper
	# Checks if a number is odd:
	def oddness(count)
		count.odd? ? "odd" :  "even"
	end
end

def title_selected_class
	params[:order] =='title' ? 'hilite' : ''
end

def release_date_selected_class
	params[:order] == 'release_date' ? 'hilite' : ''
end