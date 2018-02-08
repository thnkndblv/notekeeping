module Permission
  module OwnDecorator
    def read?
      true
    end

    def update?
      true
    end

    def share?
      true
    end

    def delete?
      true
    end
  end
end
