import 'dart:ui';

import 'package:delivery_agent_white_label/app/shared/utilities.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/confirm_popup.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/default_app_bar.dart';
import 'package:delivery_agent_white_label/app/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../../constants/properties.dart';

class DocumentsImages extends StatefulWidget {
  const DocumentsImages({Key? key}) : super(key: key);

  @override
  State<DocumentsImages> createState() => _DocumentsImagesState();
}

class _DocumentsImagesState extends State<DocumentsImages>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  OverlayEntry? addDocumentsOverlay;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: maxHeight(context),
            width: maxWidth(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              padding: EdgeInsets.only(top: wXD(70, context)),
              child: Column(
                children: [
                  SizedBox(height: wXD(15, context)),
                  DocumentImage(),
                  DocumentImage(),
                ],
              ),
            ),
          ),
          Positioned(top: 0, child: DefaultAppBar("Documentos")),
          Positioned(
            bottom: wXD(30, context),
            child: PrimaryButton(
              onTap: () {
                addDocumentsOverlay = getAddDocumentImage();
                Overlay.of(context)!.insert(addDocumentsOverlay!);
              },
              title: "Adicionar certificado",
            ),
          )
        ],
      ),
    );
  }

  OverlayEntry getAddDocumentImage() => OverlayEntry(
        builder: (context) => Material(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () => addDocumentsOverlay!.remove(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    height: maxHeight(context),
                    width: maxWidth(context),
                    color: getColors(context).shadow,
                  ),
                ),
              ),
              Container(
                width: wXD(327, context),
                height: wXD(204, context),
                padding: EdgeInsets.symmetric(vertical: wXD(23.5, context)),
                decoration: BoxDecoration(
                  borderRadius: defBorderRadius(context),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                      color: getColors(context).shadow,
                    ),
                  ],
                  color: getColors(context).surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Título do certificado",
                      style: textFamily(
                        context,
                        fontSize: 20,
                        color: getColors(context).onSurface,
                      ),
                    ),
                    Container(
                      height: wXD(40, context),
                      width: wXD(225, context),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40)),
                        color: getColors(context).primary.withOpacity(.2),
                      ),
                      alignment: Alignment.center,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        style: textFamily(
                          context,
                          fontSize: 17,
                          color: getColors(context).onSurface,
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: "Certificado",
                          hintStyle: textFamily(
                            context,
                            fontSize: 17,
                            color: getColors(context).onSurface.withOpacity(.4),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupButton(
                          text: "Cancelar",
                          width: wXD(104, context),
                          fontSize: 15,
                          onTap: () => addDocumentsOverlay!.remove(),
                        ),
                        SizedBox(width: wXD(38, context)),
                        PopupButton(
                          text: "Confirmar",
                          width: wXD(104, context),
                          fontSize: 15,
                          onTap: () => addDocumentsOverlay!.remove(),
                          inverse: true,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class DocumentImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: wXD(15, context),
        bottom: wXD(8, context),
        left: wXD(10, context),
        right: wXD(6, context),
      ),
      margin: EdgeInsets.symmetric(horizontal: wXD(24, context)),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: getColors(context).onSurface.withOpacity(.2)))),
      child: Row(
        children: [
          Container(
            height: wXD(94, context),
            width: wXD(94, context),
            margin: EdgeInsets.only(right: wXD(15, context)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: getColors(context).onBackground,
                  width: wXD(2, context)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Image.asset("./assets/images/no-image-icon.png"),
            ),
          ),
          SizedBox(
              width: wXD(170, context),
              child: Text(
                "RG/Habilitação\n(Frente)",
                style: textFamily(
                  context,
                  fontSize: 18,
                  color: getColors(context).onSurface,
                ),
              )),
          const Spacer(),
          Icon(
            Icons.arrow_forward_rounded,
            color: getColors(context).onBackground,
            size: wXD(30, context),
          )
        ],
      ),
    );
  }
}
