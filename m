Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE56E568F41
	for <lists+linux-mmc@lfdr.de>; Wed,  6 Jul 2022 18:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiGFQeu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 6 Jul 2022 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGFQeu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2022 12:34:50 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E802AC7
        for <linux-mmc@vger.kernel.org>; Wed,  6 Jul 2022 09:34:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id t189so20494367oie.8
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2022 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=LJGnMaFJxjhSkfh299eYSfGlfwRX8AM4Tggv8VCIdiRNrwP5hLPivMBFAoTkD/gB9R
         gYnlKzoLum1IUY05Wo+OM6/T3si9piF0Kpuw74BNufQXDsnu8C4uhpjXmd25lq/JCmK4
         x/pKfnbnxx+jtFB3wqGacbb7vw0MbnCV+/rWoiICbO83c4agRma8FsnOy9gC5Y6t9ahT
         qiKJNP1rPN1BSDGYEuN/AT+qDpyNLTG8DfRoYcYTT14TxjrXpFLf1pW+JbCGQPM8aG8j
         nyyX4SGv627TOheigbNJObOb6mDSRBnNTO5cI9PrMT49ifOQ/VNNN+/A0HVUMLE8Qy++
         Ha0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=kqQHF5LBR7Q+GjBrWghirJ7AfGvXgErtIpRWuA1kqbADpcfjFVN0GXRXRbwplWRY8A
         i7qSaLqTShtm5bnHpwtgX/+j7MVnPR8BGt8s6Z2DBvSHuacECwmZ1/EICEnrJrGFSmiA
         0UpoZYf+NhUVpqx2oIZ3vdWLe7yn/jkWqOWfadhGtVFiKp/LEjtUBJ22Dl1zjwM3SwsR
         39xdAhm5KeyF905d/R9sScXmdZOXgC+J6UAGuK9r1pfXDLN4EsquyVpWscNj4DgUhWCx
         GahU5wvsbh9WyrAeElZec1jQylSaD7y/PhKV1rEbckxXlUJsII2h8P0uV9SXMd3evvDx
         i3KQ==
X-Gm-Message-State: AJIora9md80xZzaJf3UQ57sCpCPVC+M0y8SeOEIQPg6Hh3diVRdPvrzS
        mB0MvRWomlNMkalaywjMxGsEYrUzuONjq+Fj6s4=
X-Google-Smtp-Source: AGRyM1sRMDGiftJ2fH2wac+siBZH3ZkDnhEWs3BtC+T7G+Z0m3e9rj0uABS/9EogkUK9wrByeHEcpcgAtaajHbL18Xo=
X-Received: by 2002:aca:1c10:0:b0:337:adbb:5d00 with SMTP id
 c16-20020aca1c10000000b00337adbb5d00mr12018846oic.232.1657125288833; Wed, 06
 Jul 2022 09:34:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4545:0:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:34:48 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <avrielharry73@gmail.com>
Date:   Wed, 6 Jul 2022 16:34:48 +0000
Message-ID: <CAFSKFDb27MPfNWaq+HdO7FNX7430xJo9Yajo+Q5JWpOJNEWHcw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4g0LTRgNCw0LPQsA0K0JLQtSDQvNC+0LvQsNC8LCDQtNCw0LvQuCDR
mNCwINC00L7QsdC40LLRgtC1INC80L7RmNCw0YLQsCDQv9GA0LXRgtGF0L7QtNC90LAg0L/QvtGA
0LDQutCwLCDQstC4INCx0LvQsNCz0L7QtNCw0YDQsNC8Lg0K
