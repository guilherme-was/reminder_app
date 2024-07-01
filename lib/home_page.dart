import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/reminder_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ReminderManager _reminderManager = ReminderManager();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _scheduleReminder() {
    if (_selectedDate != null && _selectedTime != null) {
      final DateTime now = DateTime.now();
      final DateTime scheduledDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      if (scheduledDateTime.isAfter(now)) {
        final int timeInSeconds = scheduledDateTime.difference(now).inSeconds;
        _reminderManager.scheduleReminder(
          _titleController.text,
          timeInSeconds,
          description: _descriptionController.text,
        );

        // Limpar o formulário
        _clearForm();
      }
    }
  }

  void _clearForm() {
    setState(() {
      _titleController.clear();
      _descriptionController.clear();
      _selectedDate = null;
      _selectedTime = null;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lembretes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adicionar Lembrete',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(_selectedDate == null
                  ? 'Selecionar Data'
                  : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
            ),
            TextButton(
              onPressed: () => _selectTime(context),
              child: Text(_selectedTime == null
                  ? 'Selecionar Hora'
                  : _selectedTime!.format(context)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _scheduleReminder,
              child: const Text('Criar Lembrete'),
            ),
          ],
        ),
      ),
    );
  }
}
