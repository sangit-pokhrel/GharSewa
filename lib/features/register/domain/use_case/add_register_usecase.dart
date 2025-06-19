

class AddRegisterParams {
    final String name;
    final String email;
    final String password;
    final String phone;
    final String country;
    final String province;

    AddRegisterParams({
        required this.name,
        required this.email,
        required this.password,
        required this.phone,
        required this.country,
        required this.province,
    });
class AddRegisterUsecase implements UsecaseWithParams<void, AddRegisterParams> {

    final IRegisterRepository _iregisterRepository;

    AddRegisterUsecase({required IRegisterRepository registerRepository}) : _iregisterRepository = registerRepository;

    @override
    Future<Either<Failure, void>> call(AddRegisterParams params) async {
        //to entity conversion here
        final register = RegisterEntity(
            name: params.name,
            email: params.email,
            password: params.password,
            phone: params.phone,
            country: params.country,
            province: params.province,
        );
        return await _iregisterRepository.addRegister(register);
    }



}

