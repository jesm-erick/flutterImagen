import 'dart:async';
import 'package:app_upeu/modelo/PersonaModel.dart';
import 'package:app_upeu/repository/PersonaRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'persona_event.dart';
part 'persona_state.dart';

class PersonaBloc extends Bloc<PersonaEvent, PersonaState> {
/*final PersonaRepository _PersonaRepository;
PersonaBloc({PersonaRepository PersonaRepository}) :
_PersonaRepository=PersonaRepository,
super(PersonaInitialState());*/
  final PersonaRepository _personaRepository;
  PersonaBloc({PersonaRepository personaRepository})
      : _personaRepository = personaRepository,
        super(PersonaInitialState());
  @override
  Stream<PersonaState> mapEventToState(PersonaEvent event) async* {
    if (event is ListarPersonaEvent) {
      yield PersonaLoadingState();
      try {
        List<PersonaModelo> PersonaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(PersonaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    } else if (event is DeletePersonaEvent) {
      try {
        await _personaRepository.deletePersona(event.persona.id);
        yield PersonaLoadingState();
        List<PersonaModelo> PersonaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(PersonaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    } else if (event is CreatePersonaEvent) {
      try {
        await _personaRepository.createPersona(event.persona);
        yield PersonaLoadingState();
        List<PersonaModelo> PersonaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(PersonaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    } else if (event is UpdatePersonaEvent) {
      try {
        await _personaRepository.updatePersona(event.persona.id, event.persona);
        yield PersonaLoadingState();
        List<PersonaModelo> PersonaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(PersonaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    }
  }
}
