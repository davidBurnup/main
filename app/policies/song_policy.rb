class SongPolicy
  attr_reader :user, :church

  def initialize(user, song)
    @user = user
    @song = song
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    church_atomic_authorization
  end

  def create?
    church_atomic_authorization
  end

  def edit?
    church_atomic_authorization
  end

  def update?
    church_atomic_authorization
  end

  def destroy?
    church_atomic_authorization
  end

  def church_atomic_authorization
    can = false

    # User is superadmin
    if is_super_admin = @user.has_role?("admin")
      can = true
    end

    # User is moderator of the origin church of the song
    if @user.church and @user.church == @song.origin_church and @user.has_church_role?("moderator")
      can = true
    end

    can
  end

end