Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AFA7B567F
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Oct 2023 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbjJBPL7 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 2 Oct 2023 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjJBPL6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2023 11:11:58 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C05E5
        for <linux-mmc@vger.kernel.org>; Mon,  2 Oct 2023 08:11:55 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a1d0fee86aso129893427b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2023 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696259514; x=1696864314; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y1JmPNIH7N3N84d7WPH6+MaURzQdXk6agT++CGArjQ=;
        b=dColMYiuSyoDJYaL+KiWxKdWhYFHjIRWqiYr08AuxtXCe0FTbCEFd5mnEfTp1OGkGR
         nUFMk4Q+yEvyKh6BGlJimTs1ZRD9y06BTkE+CWGPg2RfGe/08mzPLtKps5XxX0AhqvUx
         Gc9xkcH333ZwZkOHUwmnAR6PpKr7Y65IR37ZuZXFcSp/N0EA2K61FlkmA41y4ypLrYdK
         N15kClsY8Cz7JH/v8DvRTRBTHZkUcDUhu9yk02/p0zSyHyNfw0D0uzJUl+87EBUGtR5E
         tGJ1buQB32r3MaATFgsqVg+7am33qcwAERMrz4bijKHPLxu2c+KCGfo+7edbiJShv3+p
         s04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259514; x=1696864314;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y1JmPNIH7N3N84d7WPH6+MaURzQdXk6agT++CGArjQ=;
        b=aeWUlgKju6xY5267cwY7oyoteyRJZwiNjQg7rfn1XyQzwsOzs9/dFnBG7taqIVCkzX
         oKW1vU381irEePcazgjW0ZKJFZfzDx4absy6hU2v/JKBtd3Uq4PhQY1WIwGGhbiyyVsz
         r72OgMZPlNZ9asaMYZpfhLSlVN6eZl7Exs8HCxVusHpwIUtOqanwN4TwanLQW6qBseZG
         ELwi2SSaJEnlqq6bOLArfE3D20Li+tJtpNVUeiYvCWgAwq3I11sBwuJUFeWlVPMwwedx
         ThSc8kUyn6731OZksgp9VTlziZ2yVcMjwE679hZZ0ynyP1DTRBOSKWl8YLyRxuda9j0S
         MWfg==
X-Gm-Message-State: AOJu0YzyBLJnqjPfsUHbH5Z91vtan1xIh73Bjc69CnzwWuuDTc28LNo/
        /ETruggimFpvKcN51J8HGMKINcZUf//oCspQfWE=
X-Google-Smtp-Source: AGHT+IEM2akJLLeyHox479OczRn86yhJNHnZdCWwyQaf2yK8JPbTSoQAvymBAUh1Fo4wdhP3Xd824p04PbJqZD4HEvE=
X-Received: by 2002:a0d:fd45:0:b0:589:f8c7:244 with SMTP id
 n66-20020a0dfd45000000b00589f8c70244mr10977805ywf.33.1696259514200; Mon, 02
 Oct 2023 08:11:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:8c96:b0:35e:3748:1d95 with HTTP; Mon, 2 Oct 2023
 08:11:53 -0700 (PDT)
Reply-To: ansongood7@gmail.com
From:   anson brudenell <ansonbrudenell63@gmail.com>
Date:   Mon, 2 Oct 2023 08:11:53 -0700
Message-ID: <CAL21=rE-LpJQcGvH5tqrmshqQDb1695hfuogXUiqcLMO6Y2L6Q@mail.gmail.com>
Subject: =?UTF-8?B?QnVlbiBkw61hLA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Buen d=C3=ADa,
Querido, por favor, =C2=BFpuedo hablar contigo?
Saludos,
Anson Brudenell.

.........

Good Morning,
My Dear Please can I talk to you?
Regards,
Anson Brudenell.
