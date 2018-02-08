module Permission
  module UpdateDecorator
    def read?
      true
    end

    def update?
      true
    end
  end
end
