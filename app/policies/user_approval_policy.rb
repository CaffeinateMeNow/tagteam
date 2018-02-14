# frozen_string_literal: true
class UserApprovalPolicy < Struct.new(:user, :user_approval)
  def approve?
    return false unless user.present?

    user.has_role?(:superadmin)
  end

  def deny?
    return false unless user.present?

    user.has_role?(:superadmin)
  end

  def index?
    return false unless user.present?

    user.has_role?(:superadmin)
  end
end
