Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED26F54DEF5
	for <lists+linux-mmc@lfdr.de>; Thu, 16 Jun 2022 12:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359765AbiFPKZm (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 16 Jun 2022 06:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiFPKZk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2022 06:25:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9425D67E
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2022 03:25:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h23so1523642lfe.4
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2022 03:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=IwQjdxaosN8FT+UNbNdVvC2dCU/e/AII3sZs3HkWtD46tVLef+26rYjvGQVOQatkDh
         sayhBHZu7YtvR/3g7jpjxtuLJ5PCn+Boy5DPOZYZwo+LZHDU2IYC8ihKTJ+r19qh92Uk
         ZEf1lvhgmiNCA/9pv/3dsWO5Xx051NPMoXNh0fZmi7ZH9cztMCAlRXAt7cH/O1kyyaqx
         R8PyK5Zzkav+rtTReo+XRhjm6Foa0FPuvAVE2FEVIxwbxI/xgp2yAD/rXtBAsfg1HOr3
         hj0Vq2Wx/KXdx6H3h7UJcKbPEw+NyUM3MZJAkfqe32ObnHOAw/6eTl8yJpkYfp7R42OZ
         UnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=qCARdEAXH7tmSzl6hWr8ggy5wRx6JE7xeQEmug5VbuNHzPSeUGn0QfYHhppvvhXwV5
         /uz8InnmKjwctkaGBJ8Xx5WQF91Ncfv+5goIcDJpSmjDA+hpPUZG/+ljVS0O4PaSzOea
         CYicVPz2MZ5DdFYJdFP7CQGyiMbbygCQ7fEsWR6hldIINzFhVSZmUv6HlbS9Hb8BKD1l
         VB/IOb5u5hFOrTJzhBhstnrvjH+3ykCuTS3aPccHxnqSpzZSpHble7UqugNeg0oTSjQO
         F/hKRn3+PFrNj3toUhswFiO1mNDyZLTWWjtHJHWGeKHhaanMRIL7I3fXX32ZwJo8+zvb
         K35g==
X-Gm-Message-State: AJIora+eA4rVTtiFjeFvtJ7zp7XZq//7wR3Jq8REzMeCfVO21Af9ooSw
        rSx5qUBvJCqV7yTVziCELlf+3ph/er9KR7pv41o=
X-Google-Smtp-Source: AGRyM1tD/zRG3dXWQz87qWnr3BqZXXZfNnUll4esjhEBlBBP14tQnho+GeCsX1AytsBMjdK/MlaJk4cRM03i+MeC3g0=
X-Received: by 2002:a05:6512:12cc:b0:479:5cb3:96ac with SMTP id
 p12-20020a05651212cc00b004795cb396acmr2387248lfg.112.1655375133218; Thu, 16
 Jun 2022 03:25:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:28c2:b0:1f3:cf5:e20d with HTTP; Thu, 16 Jun 2022
 03:25:32 -0700 (PDT)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <bashirusman02021@gmail.com>
Date:   Thu, 16 Jun 2022 11:25:32 +0100
Message-ID: <CAGOBX5ZVYyqSLyi9qdcfunqktufqbrJ-Vvo0kCysj+Z7TLzOow@mail.gmail.com>
Subject: DARLEHENSANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Mobiltelefon:
*Land:
