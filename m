Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CFF53F9BF
	for <lists+linux-mmc@lfdr.de>; Tue,  7 Jun 2022 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiFGJ26 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 7 Jun 2022 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239538AbiFGJ2O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 05:28:14 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D6C522DE
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 02:28:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id r1so1560683ybd.4
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ohM259uqobJqtM7gttWurWj7P+4iDfPJquHax95olDY=;
        b=gujHBVxqWIlmngbJHwwatlrY6K2BhXGLJOXKENebOL4hOCXVjvoa+7rQ+wCwOuo7nz
         8e28HbaszMFtjrNu2xJwHUtJo1p0vWs5cPK29M2FpYQX1yrDGputAW1tF1NfmP59wawm
         4ciGU9SnxDgRMb84mTOs96+/9zN97uENfqj9/+eZfuG77h5pSaMszmbmnWOwi9m+gNzd
         5NtwsZACk2ULSP0cRt0MdNUxBuwzIbCfzmloCBb/Ue1QhCyZ8f6GEgrTXVIY7durHnKk
         UWQF6j7yHnTlxlvI9xCgSzii4NusQH9ADfpyzQwiF9b+OrCBSH3adFs9TwqclNBk9aQF
         O14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ohM259uqobJqtM7gttWurWj7P+4iDfPJquHax95olDY=;
        b=X7TRMxvrSLxfICkxkZXweq09OslxqwoB1whoXe+ejj9Og6K1h4E5GftkvunOTDE4Bf
         8CM4yAp4m4TTMvHprKv55OSumoS1uJMge7qfWh+mSKHghnOF0GxXsaNTvk9TArG++53S
         jbo28qaNn2EczC2NET0z++57UNd1f3BDnTClpi0ntU+uPdFf6TRtbAylV8FXw6zfzucG
         KRcdZG/x4O8MZ/LBHQZkLgEvbpzrrTLOIpuseSioAqNzFK72FmvlXRCTNurap/2ZWxuU
         AFg9WokAYHuPQHubqq06lBqDqmCuOTdikUeag3KfYdC7kIYN2yEWJIJ0tXBVt9Me1ZW6
         5g8w==
X-Gm-Message-State: AOAM5332aLdEW/FiPfOelK/glGjLYPOczgLUb55IRpDMQkDFl1B9oPft
        GdClgUw+CsJP9j2f04N6vQBCAGz72Ek+IJA9panGDHr6zG6/dp7k
X-Google-Smtp-Source: ABdhPJxTYNOyqQTj+pRtv7B26L++zgaw4oyR9fAzq9Xjy/qi86fDOL5mMOdKcDA6Petw4QZgBH7CHdeaexgYk1On3ls=
X-Received: by 2002:a05:6830:919:b0:60a:fe63:e321 with SMTP id
 v25-20020a056830091900b0060afe63e321mr11494607ott.227.1654594080399; Tue, 07
 Jun 2022 02:28:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:99a5:b0:a2:a1fa:9308 with HTTP; Tue, 7 Jun 2022
 02:28:00 -0700 (PDT)
Reply-To: robertbaileys_spende@aol.com
From:   Robert Baileys <mercymiji.j@gmail.com>
Date:   Tue, 7 Jun 2022 11:28:00 +0200
Message-ID: <CAAD1zOZ9bCDqBnjmbC3dQfgC=P2zTqAS=TP3q5qK5TFB5=Q9dQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mercymiji.j[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--=20
Hallo, lieber Beg=C3=BCnstigter,

Sie haben diese E-Mail von der Robert Bailey Foundation erhalten. Ich
bin ein pensionierter Regierungsangestellter aus Harlem und ein
Powerball-Lotterie-Jackpot-Gewinner von 343,8 Millionen Dollar. Ich
bin der gr=C3=B6=C3=9Fte Jackpot-Gewinner in der Geschichte der New York Lo=
ttery
in Amerika. Ich habe diesen Wettbewerb am 27. Oktober 2018 gewonnen
und m=C3=B6chte Ihnen mitteilen, dass Google in Kooperation mit Microsoft
Ihre "E-Mail-Adresse" f=C3=BCr meine Anfrage hat und diese 3.000.000,00
Millionen Euro kosten wird. Ich spende diese 3 Millionen Euro an Sie,
um auch Wohlt=C3=A4tigkeitsorganisationen und armen Menschen in Ihrer
Gemeinde zu helfen, damit wir die Welt zu einem besseren Ort f=C3=BCr alle
machen k=C3=B6nnen. Bitte besuchen Sie die folgende Website f=C3=BCr weiter=
e
Informationen, damit Sie diesen 3 Mio. EUR Ausgaben nicht skeptisch
gegen=C3=BCberstehen.
https://nypost.com/2018/11/14/meet-the-winner-of-the-biggest-lottery-jackpo=
t-in-new-york-history/Sie
Weitere Best=C3=A4tigungen kann ich auch auf meinem Youtube suchen:
https://www.youtube.com/watch?v=3DH5vT18Ysavc
Bitte antworten Sie mir per E-Mail (robertbaileys_spende@aol.com).
Sie m=C3=BCssen diese E-Mail sofort beantworten, damit die =C3=BCberweisend=
e
Bank mit dem Erhalt dieser Spende in H=C3=B6he von 3.000.000,00 Millionen
Euro beginnen kann.
Bitte kontaktieren Sie die untenstehende E-Mail-Adresse f=C3=BCr weitere
Informationen, damit Sie diese Spende von der =C3=BCberweisenden Bank
erhalten k=C3=B6nnen. E-Mail: robertbaileys_spende@aol.com

Gr=C3=BC=C3=9Fe,
Robert Bailey
* * * * * * * * * * * * * * * *

Powerball-Jackpot-Gewinner
E-Mail: robertbaileys_spende@aol.com
