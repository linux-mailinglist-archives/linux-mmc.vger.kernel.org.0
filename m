Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BE07307FC
	for <lists+linux-mmc@lfdr.de>; Wed, 14 Jun 2023 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFNTUW (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 14 Jun 2023 15:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjFNTUV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 15:20:21 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7F2137
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 12:20:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bd790f26791so966762276.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686770419; x=1689362419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62GFc6AuISXXvkcrUuDGzwht+jOhfItCB1t9KaG7ZR8=;
        b=E05X0deXcZmNEBaFD+iQrEPds6MnAFDwmL+RWQK6d6ohII72LuUWoByHkrC17dcMGR
         WLa1QT41qPMBUxbbJs9/jAnZWBpw/byejQuH+HUDKpL3PA4SjnGLiFKY7HY/VIASnxbk
         cZ91bIIY/6ctPO7G+JvGtzVadzRUjw48LIXofN2cbKanxkwPlFNU1pFxY8+ZhmIvx88y
         ty3arKnYRDX/XSEUcKpGcw0nu/DCNK1NLJt9XwFu6MbcNQZsPG/71gtHAhGO1dYhmgrL
         JO9VaILTaTNVoZAHhBsqyWb/GrCAsfsRtmDc0KAcobEarjQBBLJyENjD6GZkJvfpGaUe
         zBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770419; x=1689362419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62GFc6AuISXXvkcrUuDGzwht+jOhfItCB1t9KaG7ZR8=;
        b=fKA7E9BACtqG9uPBP9tpiIRx4TH+/0bP3+O1Yd8r7YYXPrF7nVmY+7an1YQijQjweE
         hOFi3oHc5MGx/ywRNPHkBVu94skpi9PG/s0IGHB3gp9MRe3i0k9LpbkktoZZQbpXJU13
         Dez0OCA489/K4Y8Tao1nkZntzNyuJkM/tUlbummqD5/8HK4erLAlwhdKKtZRIN14rSjD
         BhTPCoCWs2lCsMaSscdjDLHk2ExiK79Z0vuY9/mQID8LfLzi24fL5z+VEKJB54dW/d9T
         aH7s0XPRe1x08tWPdiw1ivgHSnlm7peZpg9T0KvO0nvoPesMx0NMp5lf8cvr4NTfnKzV
         sS7A==
X-Gm-Message-State: AC+VfDyP1vUb2aHSOQZGWUa1SM9r8O3MtXFLNkYlvBiXpZQPcReNO7qm
        Z0m3oHDVnFhoC/HIJlJsSv44e4LBSUdPzv165AEfgg==
X-Google-Smtp-Source: ACHHUZ7XahJk1hXaPJNxEreyTt5vCy4LzZhRlq/ge2nEmlCnEb/xmxNddg1oJpQIgjnlhO14CHtDFUrt/ScznOeVRVg=
X-Received: by 2002:a25:2515:0:b0:bac:1522:f870 with SMTP id
 l21-20020a252515000000b00bac1522f870mr2609764ybl.52.1686770419378; Wed, 14
 Jun 2023 12:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org>
 <20230405-pl180-busydetect-fix-v4-10-df9c8c504353@linaro.org> <CAPDyKFrq2doTP-7Pdi3cAUtGy9fhqi9mjDZDEhSAdaEd_y+YpA@mail.gmail.com>
In-Reply-To: <CAPDyKFrq2doTP-7Pdi3cAUtGy9fhqi9mjDZDEhSAdaEd_y+YpA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 21:20:08 +0200
Message-ID: <CACRpkdaXS+N+O0PPeFrZ-_h3wztiAe5QtEoDhJgT4kVYganu7Q@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] mmc: mmci: Add busydetect timeout
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 14, 2023 at 2:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> Shouldn't we schedule the work at the point when we move to
> MMCI_BUSY_WAITING_FOR_START_IRQ instead?

Yup

> > +/*
> > + * This busy timeout worker is used to "kick" the command IRQ if a
> > + * busy detect IRQ fails to appear in reasonable time. Only used on
> > + * variants with busy detection IRQ delivery.
> > + */
> > +static void busy_timeout_work(struct work_struct *work)
>
> In a way to try to be consistent with naming functions, perhaps add
> the prefix "ux500_*?

I thought to actually propose a patch for STM32 to use this too, as an
extra fallback timeout. But I don't know if it's useful to them, so I'll
rename it.

Yours,
Linus Walleij
