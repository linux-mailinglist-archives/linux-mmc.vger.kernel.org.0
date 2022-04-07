Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C94F80A4
	for <lists+linux-mmc@lfdr.de>; Thu,  7 Apr 2022 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiDGNgL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 7 Apr 2022 09:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbiDGNgK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 09:36:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9961424E276
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 06:34:09 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j8so4884440pll.11
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LecENqONxNDBAseFsv+yDhFyPls8aMa2Pn5px1MzNgs=;
        b=SNVQsECUOhAnMXWe+UjUMFAgdsqd7XUifjb4bfJYOLZnIKHBi4i8MdLoYD/VJN5npQ
         ctsVWpetAORfAvD7qB8u2UbugFjzvNsmGsw/T6yAhncEMsHFcsagKYtrBWv8ohdq33ab
         vLCxRcy9Kioj6o/JFfvgp61Sym2XdXCXyG/O90k5emR50NqxSfuIL6KkDkoEY1mF/YnN
         UVeNrY0mILt0tNCs0eggKzXS3PNaW4S1PCaIgtFS4awdgOWs9+fAVdgXb5kDxd4uTFLu
         UcjFWXIaXpsyY8HNt2FUPxsPBe0eUQqfKGpELLKCgvV/DqOo8Opv2L+WTLHsrQrfAHUV
         yZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=LecENqONxNDBAseFsv+yDhFyPls8aMa2Pn5px1MzNgs=;
        b=VD5o+ReqYbtAQR+5/bKCn6uxZidlQ+0jvqBdO2Y7J0SYrw18UQQI7cKq5hdRqIp5NN
         u9Js8rFSEtAWHnMlsf9MjXrEGKXYSQJmvSjCmkf1BiXQwIXN1YwKD43OpibE+tX9crI7
         C6cCEgMezWIVv97fo7ghVrYmE19Y/3lLa3A14NiUslD9vXd5frmq+RYcmaEUINo5K2O0
         pPTvx5yjdtWBmutvdx11rvAuAssDc74+9j0I28bGNITYGF6NBjJWaiZMAWv5WqHD0Y2Q
         yN7XoVwKaOAxIsXO/jT+/Qp53oiWCG+0DsKt3D/YRe82JC+lSKs+MuyhgOBFduKcJnFo
         FCEw==
X-Gm-Message-State: AOAM531+Jb2/5Kc862y6sZS2DI/h2/ktQTf6EVN/kq6MKA0RcNWVbxzg
        ft/QQTZ/G7rx7/PMWJhMSTwfQ59YmyiJebTBP5Y=
X-Google-Smtp-Source: ABdhPJztaQyJVTQQO0bplq/CjXZv6Kqhm68pusBvfnH3mv4EikoFL9nd6mhtZhdmhSLh4XApKqV5uVDdcxfM+79zWBs=
X-Received: by 2002:a17:902:ab01:b0:156:f1cc:6d2d with SMTP id
 ik1-20020a170902ab0100b00156f1cc6d2dmr6619175plb.127.1649338448953; Thu, 07
 Apr 2022 06:34:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:a01a:b0:7a:9fe0:c3c8 with HTTP; Thu, 7 Apr 2022
 06:34:08 -0700 (PDT)
Reply-To: anwarialima@gmail.com
From:   Alima Anwari <nadiazato3@gmail.com>
Date:   Thu, 7 Apr 2022 13:34:08 +0000
Message-ID: <CAM0zFyo5P_HRgkynMUqek7=2XDBHvMqoGPKw5xbErv5deE1tWA@mail.gmail.com>
Subject: God morgon
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4389]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nadiazato3[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nadiazato3[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--=20
Hej k=C3=A4ra v=C3=A4n, jag =C3=A4r Alima Anwari fr=C3=A5n Afghanistan, v=
=C3=A4nligen svara
tillbaka till mig och har ett br=C3=A5dskande problem att dela med dig. jag
kommer att v=C3=A4nta
f=C3=B6r din respons.
Tack.
Alima.
