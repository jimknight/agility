class Tree
	
	def self.top(model)
		# TODO: stop infinite loop potential
		parent = model
		until parent.class == Project
			if parent.respond_to?(:parent_id) && parent.parent_id.present?
				parent = Note.find(parent.parent_id)
			elsif parent.respond_to?(:project_id)
				parent = Project.find(parent.project_id)
			elsif parent.respond_to?(:notable_id)
				parent = parent.notable_type.singularize.classify.constantize.find(parent.notable_id)
			end
		end
		return parent
	end
	
end