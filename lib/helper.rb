class String
	def select_indices
		indices = []
		if block_given?
			self.split("").each_index.select do |i| 
				if yield(i)
					indices << i
				end
			end
		end
		indices
	end
end