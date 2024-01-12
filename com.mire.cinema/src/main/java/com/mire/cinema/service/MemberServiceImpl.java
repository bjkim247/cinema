package com.mire.cinema.service;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.member.Member;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.TokenDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.MemberMapper;
import com.mire.cinema.security.JwtTokenProvider;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class MemberServiceImpl implements MemberService {

	private final MemberMapper memberMapper;
	private final AuthenticationManagerBuilder authenticationManagerBuilder;
	private final JwtTokenProvider jwtTokenProvider;

	@Override
	public void saveMember(Member member) {
		memberMapper.insertMember(member);

	}

	@Override
	public Member findMember(String memberId) {

		Member member = memberMapper.selectMember(memberId);

		return member;
	}

	@Override
	public void modifyMember(MemberDTO.Update dto) {
		Member member = memberMapper.selectMember(dto.getMemberId());

		if (member == null || !member.getMemberPasswd().equals(dto.getMemberPasswd())) {
			throw new IllegalArgumentException(ErrorMsg.USERINFO);

		}

		memberMapper.updateMember(dto);

	}

	@Override
	public void removeMember(String memberId) {

		Member member = findMember(memberId);

		if (member == null) {
			System.out.println("예외호출");
			throw new IllegalArgumentException(ErrorMsg.USERINFO);
		}

		memberMapper.deleteMember(memberId);

	}

	@Override
	public TokenDTO loginMember(MemberDTO.Login dto) {
		Member member = memberMapper.selectMember(dto.getMemberId());

		if (member == null || !member.getMemberPasswd().equals(dto.getMemberPasswd())) {
			throw new IllegalArgumentException(ErrorMsg.USERINFO);

		}

		UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(
				dto.getMemberId(), dto.getMemberPasswd());

		Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);

		TokenDTO tokenDTO = jwtTokenProvider.createToken(authentication);

		return tokenDTO;

	}

}
