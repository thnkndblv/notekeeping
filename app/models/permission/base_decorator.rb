module Permission
  module BaseDecorator
    def read?
      false
    end

    def update?
      false
    end

    def share?
      false
    end

    def delete?
      false
    end
  end
end
