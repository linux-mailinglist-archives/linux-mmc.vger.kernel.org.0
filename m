Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875D14D4D54
	for <lists+linux-mmc@lfdr.de>; Thu, 10 Mar 2022 16:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239141AbiCJPjY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 10 Mar 2022 10:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238868AbiCJPjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2022 10:39:22 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50D3E33B6
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2022 07:38:20 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so7174432ooc.4
        for <linux-mmc@vger.kernel.org>; Thu, 10 Mar 2022 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=U6/M8FbykupguSAvKJiv2o4OcRk33Rmd1Jw/TK/TYKM=;
        b=YY4CO5qX+e3FARyOeoczCg1ix+KOnQ9YAChmFSLMKdHK0cUspE3AKICPXiKgfpt+t+
         6tADouEkIjC8CAmDfZBKhKt5/fO/YbS8cBOTJo4TDWQ5GMTcW6tmUvNlrgsvzXvYb2NW
         WeeCrCyDr8FEuK1AP2Tu1L0i5QeftZceVvvouk9+3BRvo6M3zY2DPMRslhlXiXPZ2tLF
         hBunOR5TzCFsOhvN5A2TsA7Zowv5Ed8SlsCXFmC8xbeK8P6zXcq9FpmrBIOzlVgssJbl
         nrNxxqkSKCXinvcpur6cQtdvWU79MuvmD4B6L90XDMjGVR0IuGFp7tvgWVdZH8TPsBsc
         iPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=U6/M8FbykupguSAvKJiv2o4OcRk33Rmd1Jw/TK/TYKM=;
        b=GaFGWfA1pnFZmC/YsLdt2VO02tor5zvCgz+lS6KAI6gZdcSkaQpQrbXvbT89loru5C
         hfK/WYFCpJmpDlLW0Gj84lizdwWIQQbcOCzuZFdPWXnB5IG/y4pT6vFhYfOx2ifIuLKc
         QzLv/KCDBIhbhhEbyDl2o0a3GVcGXVWK3AqjCeZ6prb+fou2Ss6ppoar2SDauLCG8dFM
         Mff1/jyIt0MeYM2Gda6DaK/eDYmHuYC6PbtI6DDkrOmiuozsm2M248BqNcOPCHVir9Vz
         vIJuk8ZixMvP3ytgZBHu9xv3j6FRbPimeHr2itCIbCQF0BVbw+Qmn3/47aRpMf7qZdrU
         PlQw==
X-Gm-Message-State: AOAM532Hud3qeiTxD4hUsuT2Q4YORISwDmlYIbFpnp7Q0wdBfGwRTbpQ
        jaVR+2jB3dX3XeBbq7qIzpaM0rwnra0MaKn9dMI=
X-Google-Smtp-Source: ABdhPJw+XK4hPbmICOqVnfqQ6UPJG9T+QwbcRmkYs+J872+Tzxt4ugVnMVvy1rZhxTNdVhHCmi88DEKiB4/Y+0AXv6A=
X-Received: by 2002:a05:6870:829f:b0:d9:9fcc:efe7 with SMTP id
 q31-20020a056870829f00b000d99fccefe7mr8773338oae.151.1646926700128; Thu, 10
 Mar 2022 07:38:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6838:a5eb:0:0:0:0 with HTTP; Thu, 10 Mar 2022 07:38:19
 -0800 (PST)
Reply-To: alicewatosm@yahoo.com
From:   Mr suvo Sarkar Emirates NBD Bank Dubai <alzarounia16@gmail.com>
Date:   Thu, 10 Mar 2022 16:38:19 +0100
Message-ID: <CA+zH+qXwLOLahG-Zfe9u1snFrRCQd_VNrWN-8M-2+rXOOF83NA@mail.gmail.com>
Subject: Read my message and reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alzarounia16[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alzarounia16[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-- 
hello friend,
I have an urgent message to discuss with you. Kindly get back to me
for more details
Mr Suvo Sarkar.
General Manager, Retail Banking and Wealth Management Bank UAE
