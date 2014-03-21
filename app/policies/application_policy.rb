class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
  end

  def index?
  end

  def show?
  end

  def create?
  end

  def new?
  end

  def update?
  end

  def edit?
  end

  def destroy?
  end

  def scope
  end
end

